module MarkdownSanitazable
  extend ActiveSupport::Concern

  private

  def sanitize_markdown(content, max_length: 160)
    return "" if content.blank?

    # Convert markdown to html
    html = RDiscount.new(content, :filter_html, :filter_styles).to_html

    plain_text = ActionView::Base.full_sanitizer.sanitize(html).strip.gsub(/\s+/, " ")
    plain_text.truncate(max_length)
  end
end
