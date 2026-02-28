# heroicon-rails — contributor guide

Fork of [carlweis/heroicon-rails](https://github.com/carlweis/heroicon-rails), maintained at [mattes/heroicon-rails](https://github.com/mattes/heroicon-rails).

## Project structure

```
lib/heroicon/rails.rb                  # Entry point (requires version, railtie, nokogiri)
lib/heroicon/rails/version.rb          # VERSION constant
lib/heroicon/rails/railtie.rb          # Includes HeroiconHelper into ActionView::Base
lib/heroicon/rails/heroicon_helper.rb  # Core: heroicon() method
lib/heroicon/rails/assets/heroicons/   # SVG icon files
  solid/    (324 icons, 24x24)
  outline/  (324 icons, 24x24)
  mini/     (324 icons, 20x20)
  micro/    (316 icons, 16x16)
spec/helpers/heroicon_helper_spec.rb   # Helper tests (19 examples)
spec/heroicon/rails_spec.rb            # Version test
```

## Setup and commands

```bash
mise install              # Install Ruby 3.3.9
bundle install            # Install dependencies
bundle exec rspec         # Run tests
bundle exec rubocop       # Run linter
bundle exec rake          # Run both (default task)
```

## Code style

- Double quotes for all strings (RuboCop enforced)
- Max line length: 120
- `frozen_string_literal: true` in all Ruby files
- Ruby >= 3.2.0, Rails 8+ (activesupport >= 8.0)

## How it works

1. `Railtie` includes `HeroiconHelper` into `ActionView::Base` on Rails boot
2. `heroicon(name, type:, **options)` validates inputs, then reads SVG from `assets/heroicons/{type}/{name}.svg`
3. Nokogiri parses the SVG and injects: CSS classes, optional `<title>` + `role="img"`, and any user-provided HTML attributes
4. Returns `html_safe` string; raises `ArgumentError` for invalid name/type, `Errno::ENOENT` for missing icon files

## Syncing icons from upstream

Icons come from [tailwindlabs/heroicons](https://github.com/tailwindlabs/heroicons) `master` branch:

| Upstream path | Local path |
|---------------|------------|
| `src/24/solid/` | `assets/heroicons/solid/` |
| `src/24/outline/` | `assets/heroicons/outline/` |
| `src/20/solid/` | `assets/heroicons/mini/` |
| `src/16/solid/` | `assets/heroicons/micro/` |

Clone heroicons, diff file lists, copy new SVGs. No build step — raw SVGs used directly. New icons must be git-committed to be included in the gem (gemspec uses `git ls-files`).

## Key gotchas

- `name` and `type` are validated before file access to prevent path traversal (`VALID_TYPES`, `VALID_NAME_PATTERN`)
- No `<title>` is added by default — only when `title:` is explicitly passed (avoids unwanted browser tooltips)
- The micro type has 8 fewer icons than the others (no arrow-small-*, minus-small, plus-small, arrow-*-on-rectangle)
