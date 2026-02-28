# heroicon-rails — using Heroicons in Rails views

This project uses the `heroicon-rails` gem to render [Heroicons](https://heroicons.com) SVG icons inline in Rails views. When adding icons to views, always use the `heroicon` helper — never paste raw SVG markup.

## Helper signature

```ruby
heroicon(name, type: "solid", class: nil, style: nil, title: nil, **html_attributes)
```

Returns an HTML-safe SVG string. Both strings and symbols work for `name` and `type`.

## Icon types

| Type | Use case | Default size |
|------|----------|--------------|
| `"solid"` | Filled icons, primary actions, emphasis | `w-6 h-6` (24px) |
| `"outline"` | Lighter weight, secondary UI, navigation | `w-6 h-6` (24px) |
| `"mini"` | Buttons, form elements, compact UI | `w-5 h-5` (20px) |
| `"micro"` | Inline with text, badges, tight spaces | `w-4 h-4` (16px) |

## Usage examples

### Basic

```erb
<%= heroicon "bolt" %>
<%= heroicon "bolt", type: :outline %>
<%= heroicon "bolt", type: :mini %>
<%= heroicon "bolt", type: :micro %>
```

### Custom size and color (Tailwind classes)

```erb
<%= heroicon "user", class: "w-10 h-10 text-blue-500" %>
<%= heroicon "heart", class: "w-4 h-4 text-red-600" %>
```

Providing `w-*` or `h-*` classes overrides the default size for that dimension.

### Title for accessibility

```erb
<%= heroicon "arrow-left", title: "Go back" %>
```

When `title:` is provided, a `<title>` element and `role="img"` are added to the SVG. Without `title:`, no title element is added (no tooltip on hover).

### Data and aria attributes

Any keyword argument is passed through as an HTML attribute on the `<svg>`:

```erb
<%= heroicon "trash", "data-controller": "delete", "data-action": "click->delete#confirm" %>
<%= heroicon "bell", id: "alerts", "aria-hidden": "true" %>
```

### Inline style

```erb
<%= heroicon "star", style: "color: gold;" %>
```

## Common UI patterns

```erb
<%# Button with icon and text %>
<button class="inline-flex items-center gap-2">
  <%= heroicon "plus", type: :mini, class: "w-5 h-5" %>
  Add item
</button>

<%# Icon-only button %>
<button aria-label="Delete">
  <%= heroicon "trash", class: "w-5 h-5", "aria-hidden": "true" %>
</button>

<%# Link with icon %>
<%= link_to root_path, class: "inline-flex items-center gap-1" do %>
  <%= heroicon "home", type: :mini %>
  <span>Home</span>
<% end %>

<%# Inline warning %>
<p class="inline-flex items-center gap-1 text-yellow-600">
  <%= heroicon "exclamation-triangle", type: :micro %>
  This action cannot be undone.
</p>

<%# Status indicators %>
<%= heroicon "check-circle", class: "w-5 h-5 text-green-500" %>
<%= heroicon "x-circle", class: "w-5 h-5 text-red-500" %>
<%= heroicon "clock", type: :outline, class: "w-5 h-5 text-gray-400" %>
```

### Slim

```slim
= heroicon "bolt"
= heroicon "bolt", type: :outline, class: "w-8 h-8 text-yellow-400"
```

## Error handling

If the icon name doesn't exist, the helper raises `Errno::ENOENT`.

## Accessibility

Icons are rendered as plain `<svg>` elements by default (no title, no role). Use `"aria-hidden": "true"` for decorative icons next to visible text, and `aria-label` on the parent element for icon-only buttons.

## Available icons (324 names)

All 324 icons are available in `solid`, `outline`, and `mini` types. The `micro` type has 316 (missing: arrow-left-on-rectangle, arrow-right-on-rectangle, arrow-small-down, arrow-small-left, arrow-small-right, arrow-small-up, minus-small, plus-small).

academic-cap, adjustments-horizontal, adjustments-vertical, archive-box, archive-box-arrow-down, archive-box-x-mark, arrow-down, arrow-down-circle, arrow-down-left, arrow-down-on-square, arrow-down-on-square-stack, arrow-down-right, arrow-down-tray, arrow-left, arrow-left-circle, arrow-left-end-on-rectangle, arrow-left-on-rectangle, arrow-left-start-on-rectangle, arrow-long-down, arrow-long-left, arrow-long-right, arrow-long-up, arrow-path, arrow-path-rounded-square, arrow-right, arrow-right-circle, arrow-right-end-on-rectangle, arrow-right-on-rectangle, arrow-right-start-on-rectangle, arrow-small-down, arrow-small-left, arrow-small-right, arrow-small-up, arrows-pointing-in, arrows-pointing-out, arrows-right-left, arrows-up-down, arrow-top-right-on-square, arrow-trending-down, arrow-trending-up, arrow-turn-down-left, arrow-turn-down-right, arrow-turn-left-down, arrow-turn-left-up, arrow-turn-right-down, arrow-turn-right-up, arrow-turn-up-left, arrow-turn-up-right, arrow-up, arrow-up-circle, arrow-up-left, arrow-up-on-square, arrow-up-on-square-stack, arrow-up-right, arrow-up-tray, arrow-uturn-down, arrow-uturn-left, arrow-uturn-right, arrow-uturn-up, at-symbol, backspace, backward, banknotes, bars-2, bars-3, bars-3-bottom-left, bars-3-bottom-right, bars-3-center-left, bars-4, bars-arrow-down, bars-arrow-up, battery-0, battery-100, battery-50, beaker, bell, bell-alert, bell-slash, bell-snooze, bold, bolt, bolt-slash, bookmark, bookmark-slash, bookmark-square, book-open, briefcase, bug-ant, building-library, building-office, building-office-2, building-storefront, cake, calculator, calendar, calendar-date-range, calendar-days, camera, chart-bar, chart-bar-square, chart-pie, chat-bubble-bottom-center, chat-bubble-bottom-center-text, chat-bubble-left, chat-bubble-left-ellipsis, chat-bubble-left-right, chat-bubble-oval-left, chat-bubble-oval-left-ellipsis, check, check-badge, check-circle, chevron-double-down, chevron-double-left, chevron-double-right, chevron-double-up, chevron-down, chevron-left, chevron-right, chevron-up, chevron-up-down, circle-stack, clipboard, clipboard-document, clipboard-document-check, clipboard-document-list, clock, cloud, cloud-arrow-down, cloud-arrow-up, code-bracket, code-bracket-square, cog, cog-6-tooth, cog-8-tooth, command-line, computer-desktop, cpu-chip, credit-card, cube, cube-transparent, currency-bangladeshi, currency-dollar, currency-euro, currency-pound, currency-rupee, currency-yen, cursor-arrow-rays, cursor-arrow-ripple, device-phone-mobile, device-tablet, divide, document, document-arrow-down, document-arrow-up, document-chart-bar, document-check, document-currency-bangladeshi, document-currency-dollar, document-currency-euro, document-currency-pound, document-currency-rupee, document-currency-yen, document-duplicate, document-magnifying-glass, document-minus, document-plus, document-text, ellipsis-horizontal, ellipsis-horizontal-circle, ellipsis-vertical, envelope, envelope-open, equals, exclamation-circle, exclamation-triangle, eye, eye-dropper, eye-slash, face-frown, face-smile, film, finger-print, fire, flag, folder, folder-arrow-down, folder-minus, folder-open, folder-plus, forward, funnel, gif, gift, gift-top, globe-alt, globe-americas, globe-asia-australia, globe-europe-africa, h1, h2, h3, hand-raised, hand-thumb-down, hand-thumb-up, hashtag, heart, home, home-modern, identification, inbox, inbox-arrow-down, inbox-stack, information-circle, italic, key, language, lifebuoy, light-bulb, link, link-slash, list-bullet, lock-closed, lock-open, magnifying-glass, magnifying-glass-circle, magnifying-glass-minus, magnifying-glass-plus, map, map-pin, megaphone, microphone, minus, minus-circle, minus-small, moon, musical-note, newspaper, no-symbol, numbered-list, paint-brush, paper-airplane, paper-clip, pause, pause-circle, pencil, pencil-square, percent-badge, phone, phone-arrow-down-left, phone-arrow-up-right, phone-x-mark, photo, play, play-circle, play-pause, plus, plus-circle, plus-small, power, presentation-chart-bar, presentation-chart-line, printer, puzzle-piece, qr-code, question-mark-circle, queue-list, radio, receipt-percent, receipt-refund, rectangle-group, rectangle-stack, rocket-launch, rss, scale, scissors, server, server-stack, share, shield-check, shield-exclamation, shopping-bag, shopping-cart, signal, signal-slash, slash, sparkles, speaker-wave, speaker-x-mark, square-2-stack, square-3-stack-3d, squares-2x2, squares-plus, star, stop, stop-circle, strikethrough, sun, swatch, table-cells, tag, ticket, trash, trophy, truck, tv, underline, user, user-circle, user-group, user-minus, user-plus, users, variable, video-camera, video-camera-slash, view-columns, viewfinder-circle, wallet, wifi, window, wrench, wrench-screwdriver, x-circle, x-mark
