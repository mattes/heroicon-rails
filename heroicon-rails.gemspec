# frozen_string_literal: true

require_relative "lib/heroicon/rails/version"

Gem::Specification.new do |spec|
  spec.name = "heroicon-rails"
  spec.version = Heroicon::Rails::VERSION
  spec.authors = ["Carl Weis"]
  spec.email = ["carl@carlweis.com"]

  spec.summary = "A Ruby gem providing a helper for easily embedding Heroicons SVG icons in Rails applications."
  spec.description = "Provides a helper method for embedding Heroicons (solid, outline, mini, micro) in Rails views."
  spec.homepage = "https://github.com/mattes/heroicon-rails"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mattes/heroicon-rails"
  spec.metadata["changelog_uri"] = "https://github.com/mattes/heroicon-rails/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 8.0"
  spec.add_dependency "nokogiri", ">= 1.16"
end
