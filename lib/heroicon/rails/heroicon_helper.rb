# frozen_string_literal: true

module HeroiconHelper # :nodoc:
  HEROICONS_PATH = File.expand_path("assets/heroicons", __dir__)
  VALID_TYPES = %w[solid outline mini micro].freeze
  VALID_NAME_PATTERN = /\A[a-z0-9-]+\z/

  # Returns an SVG icon from the Heroicons library.
  # @param name [String, Symbol] the name of the icon
  # @param type [String, Symbol] the style of the icon (default: "solid")
  # @return [String] HTML-safe SVG string
  def heroicon(name, type: "solid", **options)
    name = name.to_s
    type = type.to_s
    validate_arguments!(name, type)
    svg, doc = load_svg(type, name)
    apply_classes(svg, type, options.delete(:class) || "")
    apply_style(svg, options.delete(:style))
    apply_title(svg, doc, options.delete(:title))
    apply_html_attributes(svg, options)
    doc.to_html.html_safe
  end

  private

  def validate_arguments!(name, type)
    raise ArgumentError, "Invalid icon type: #{type.inspect}" unless VALID_TYPES.include?(type)
    raise ArgumentError, "Invalid icon name: #{name.inspect}" unless VALID_NAME_PATTERN.match?(name)
  end

  def load_svg(type, name)
    icon_path = File.join(HEROICONS_PATH, type, "#{name}.svg")
    doc = Nokogiri::HTML::DocumentFragment.parse(File.read(icon_path))
    [doc.at_css("svg"), doc]
  end

  def apply_classes(svg, type, custom_class)
    default_w, default_h = default_size(type)
    width = custom_class[/\bw-\d+/] ? "" : default_w
    height = custom_class[/\bh-\d+/] ? "" : default_h
    css_classes = [width, height, custom_class].reject(&:empty?).join(" ")
    svg[:class] = css_classes unless css_classes.empty?
  end

  def default_size(type)
    case type
    when "micro" then %w[w-4 h-4]
    when "mini" then %w[w-5 h-5]
    else %w[w-6 h-6]
    end
  end

  def apply_style(svg, style)
    svg[:style] = style if style
  end

  def apply_title(svg, doc, title)
    return unless title

    svg[:role] = "img"
    title_element = Nokogiri::XML::Node.new("title", doc)
    title_element.content = title
    svg.prepend_child(title_element)
  end

  def apply_html_attributes(svg, options)
    options.each { |key, value| svg[key.to_s] = value }
  end
end
