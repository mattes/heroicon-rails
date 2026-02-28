# frozen_string_literal: true

require "spec_helper"
require "nokogiri"

RSpec.describe HeroiconHelper, type: :helper do
  include HeroiconHelper

  describe "#heroicon" do
    it "returns an html_safe SVG string" do
      html = heroicon("bolt")
      expect(html).to include("<svg")
      expect(html).to be_html_safe
    end

    it "applies default solid classes" do
      html = heroicon("bolt")
      expect(html).to include('class="w-6 h-6"')
    end

    it "applies custom classes alongside defaults" do
      html = heroicon("bolt", class: "custom-class")
      expect(html).to include('class="w-6 h-6 custom-class"')
    end

    it "handles outline type" do
      html = heroicon("bolt", type: "outline")
      expect(html).to include("<svg")
      expect(html).to include('class="w-6 h-6"')
    end

    it "handles mini type with w-5 h-5 defaults" do
      html = heroicon("bolt", type: "mini")
      expect(html).to include('class="w-5 h-5"')
    end

    it "handles micro type with w-4 h-4 defaults" do
      html = heroicon("bolt", type: "micro")
      expect(html).to include('class="w-4 h-4"')
    end

    it "suppresses default width when custom w-* class is provided" do
      html = heroicon("bolt", class: "w-10")
      expect(html).to include('class="h-6 w-10"')
    end

    it "suppresses default height when custom h-* class is provided" do
      html = heroicon("bolt", class: "h-10")
      expect(html).to include('class="w-6 h-10"')
    end

    it "suppresses both defaults when custom w-* and h-* classes are provided" do
      html = heroicon("bolt", class: "w-10 h-10")
      expect(html).to include('class="w-10 h-10"')
    end

    it "passes through style attribute" do
      html = heroicon("bolt", style: "color: gold;")
      expect(html).to include('style="color: gold;"')
    end

    it "does not add a title element by default" do
      doc = Nokogiri::HTML::DocumentFragment.parse(heroicon("bolt"))
      expect(doc.at_css("title")).to be_nil
    end

    it "adds title and role=img when title is provided" do
      doc = Nokogiri::HTML::DocumentFragment.parse(heroicon("bolt", title: "Lightning"))
      expect(doc.at_css("title").text).to eq("Lightning")
      expect(doc.at_css("svg")["role"]).to eq("img")
    end

    it "passes through data- attributes" do
      html = heroicon("bolt", "data-controller": "icon")
      expect(html).to include('data-controller="icon"')
    end

    it "passes through aria- attributes" do
      html = heroicon("bolt", "aria-hidden": "true")
      expect(html).to include('aria-hidden="true"')
    end

    it "accepts symbols for name and type" do
      html = heroicon(:bolt, type: :outline)
      expect(html).to include("<svg")
    end

    it "raises Errno::ENOENT for a nonexistent icon name" do
      expect { heroicon("nonexistent-icon") }.to raise_error(Errno::ENOENT)
    end

    it "raises ArgumentError for an invalid icon name" do
      expect { heroicon("../../etc/passwd") }.to raise_error(ArgumentError, /Invalid icon name/)
    end

    it "raises ArgumentError for an invalid type" do
      expect { heroicon("bolt", type: "bad") }.to raise_error(ArgumentError, /Invalid icon type/)
    end
  end
end
