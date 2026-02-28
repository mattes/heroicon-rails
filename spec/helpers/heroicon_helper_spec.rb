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

    it "generates unique IDs for aria-labelledby" do
      html1 = heroicon("bolt")
      html2 = heroicon("bolt")
      doc1 = Nokogiri::HTML::DocumentFragment.parse(html1)
      doc2 = Nokogiri::HTML::DocumentFragment.parse(html2)
      id1 = doc1.at_css("title")["id"]
      id2 = doc2.at_css("title")["id"]
      expect(id1).not_to eq(id2)
    end

    it "passes through data- attributes" do
      html = heroicon("bolt", "data-controller": "icon")
      expect(html).to include('data-controller="icon"')
    end

    it "passes through aria- attributes" do
      html = heroicon("bolt", "aria-hidden": "true")
      expect(html).to include('aria-hidden="true"')
    end

    it "allows overriding the title" do
      html = heroicon("bolt", title: "Lightning")
      doc = Nokogiri::HTML::DocumentFragment.parse(html)
      expect(doc.at_css("title").text).to eq("Lightning")
    end

    it "accepts symbols for name and type" do
      html = heroicon(:bolt, type: :outline)
      expect(html).to include("<svg")
    end
  end
end
