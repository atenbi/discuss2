module MarkdownHelper
  def render_markdown(input)
    return "" if input.nil? || input.empty?

    html = RDiscount.new(input, :filter_html, :filter_styles, :autolink).to_html
    doc = sanitize_html(html)
    add_link_attributes(doc)
    doc.to_html.html_safe
  end

  private

  def sanitize_html(html)
    doc = Nokogiri::HTML::DocumentFragment.parse(html)
    remove_headings(doc)
    doc
  end

  def remove_headings(doc)
    doc.css("h1, h2, h3, h4, h5, h6").each do |heading|
      heading.replace("<p>#{heading.text}</p>")
    end
  end

  def add_link_attributes(doc)
    doc.css("a").each do |link|
      existing_rel = link["rel"].to_s.split(" ")
      updated_rel = (existing_rel + %w[nofollow noopener noreferrer]).uniq
      link["rel"] = updated_rel.join(" ")

      link["target"] = "_blank"
    end
    doc
  end
end
