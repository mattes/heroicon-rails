# frozen_string_literal: true

require "rails/railtie"

module Heroicon
  module Rails
    # Includes HeroiconHelper into ActionView::Base on Rails boot.
    class Railtie < ::Rails::Railtie
      initializer "heroicon.view_helpers" do
        ActionView::Base.include HeroiconHelper
      end
    end
  end
end
