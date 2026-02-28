require "spec_helper"
require "nokogiri"

RSpec.describe HeroiconHelper, type: :helper do
  include HeroiconHelper
  describe "#heroicon" do
    it "returns the correct HTML for a valid icon" do
      icon_name = "bolt"
      html = heroicon(icon_name)
      expect(html).to include("<svg")
      expect(html).to include("class=\"w-6 h-6\"")
    end

    it "returns an error string for an invalid icon" do
      expect(heroicon("invalid-icon")).to eq("Icon invalid-icon not found")
    end

    it "applies custom classes" do
      icon_name = "bolt"
      icon_class = "custom-class"
      html = heroicon(icon_name, class: icon_class)
      expect(html).to include("class=\"w-6 h-6 #{icon_class}\"")
    end

    it "handles mini type" do
      icon_name = "bolt"
      html = heroicon(icon_name, type: "mini")
      expect(html).to include("class=\"w-5 h-5\"")
    end

    it "handles micro type" do
      icon_name = "bolt"
      html = heroicon(icon_name, type: "micro")
      expect(html).to include("class=\"w-4 h-4\"")
    end

    it "does not add a title element by default" do
      html = heroicon("bolt")
      doc = Nokogiri::HTML::DocumentFragment.parse(html)
      expect(doc.at_css("title")).to be_nil
    end

    it "passes through data- attributes" do
      html = heroicon("bolt", "data-controller": "icon")
      expect(html).to include('data-controller="icon"')
    end

    it "passes through aria- attributes" do
      html = heroicon("bolt", "aria-hidden": "true")
      expect(html).to include('aria-hidden="true"')
    end

    it "adds title and role=img when title is provided" do
      html = heroicon("bolt", title: "Lightning")
      doc = Nokogiri::HTML::DocumentFragment.parse(html)
      expect(doc.at_css("title").text).to eq("Lightning")
      expect(doc.at_css("svg")["role"]).to eq("img")
    end

    it "accepts symbols for name and type" do
      html = heroicon(:bolt, type: :outline)
      expect(html).to include("<svg")
    end
  end
end
