require "rails_helper"

RSpec.describe MarkdownHelper, type: :helper do
  describe "#render_markdown" do
    context "basic markdown conversion" do
      it "converts markdown to HTML (headings become paragraphs)" do
        markdown = "# Hello World"
        result = helper.render_markdown(markdown)

        expect(result).to include("<p>Hello World</p>")
      end

      it "converts bold text" do
        markdown = "**bold text**"
        result = helper.render_markdown(markdown)

        expect(result).to include("<strong>bold text</strong>")
      end

      it "converts italic text" do
        markdown = "*italic text*"
        result = helper.render_markdown(markdown)

        expect(result).to include("<em>italic text</em>")
      end

      it "converts links" do
        markdown = "[Example](https://example.com)"
        result = helper.render_markdown(markdown)

        expect(result).to include('href="https://example.com"')
        expect(result).to include('rel="nofollow noopener noreferrer"')
        expect(result).to include('target="_blank"')
      end
    end

    context "security features" do
      it "filters out dangerous HTML tags" do
        markdown = "<script>alert('xss')</script>Safe content"
        result = helper.render_markdown(markdown)

        expect(result).not_to include("<script>")
        expect(result).to include("Safe content")
      end

      it "adds security attributes to links" do
        markdown = "[Link](https://example.com)"
        result = helper.render_markdown(markdown)

        expect(result).to include('rel="nofollow noopener noreferrer"')
        expect(result).to include('target="_blank"')
      end
    end

    context "edge cases" do
      it "handles empty input" do
        result = helper.render_markdown("")
        expect(result.strip).to eq("")
      end

      it "handles nil input" do
        result = helper.render_markdown(nil)
        expect(result.strip).to eq("")
      end
    end

    context "complex markdown" do
      it "handles mixed content (headings become paragraphs)" do
        markdown = <<~MD
          # Title

          This is **bold** and *italic* text.

          [Link](https://example.com)

          - List item 1
          - List item 2
        MD

        result = helper.render_markdown(markdown)

        expect(result).to include("<p>Title</p>")
        expect(result).to include("<strong>bold</strong>")
        expect(result).to include("<em>italic</em>")
        expect(result).to include('href="https://example.com"')
        expect(result).to include("<li>List item 1</li>")
      end
    end
  end

  describe "private methods" do
    describe "#sanitize_html" do
      it "parses HTML and converts headings to paragraphs" do
        html = "<h1>Title</h1><p>Content</p><strong>Bold</strong>"
        result = helper.send(:sanitize_html, html)

        expect(result).to be_a(Nokogiri::HTML::DocumentFragment)
        expect(result.to_html).not_to include("<h1>")
        expect(result.to_html).to include("<p>Title</p>")
        expect(result.to_html).to include("<p>Content</p>")
        expect(result.to_html).to include("<strong>Bold</strong>")
      end

      it "handles empty HTML input" do
        html = ""
        result = helper.send(:sanitize_html, html)

        expect(result).to be_a(Nokogiri::HTML::DocumentFragment)
        expect(result.to_html.strip).to eq("")
      end

      it "preserves non-heading HTML elements" do
        html = "<p>Paragraph</p><ul><li>Item</li></ul><em>Italic</em>"
        result = helper.send(:sanitize_html, html)

        expect(result.to_html).to include("<p>Paragraph</p>")
        expect(result.to_html).to include("<ul><li>Item</li></ul>")
        expect(result.to_html).to include("<em>Italic</em>")
      end
    end

    describe "#remove_headings" do
      it "removes heading tags" do
        doc = Nokogiri::HTML::DocumentFragment.parse("<h1>Title</h1><p>Content</p>")
        helper.send(:remove_headings, doc)

        expect(doc.to_html).not_to include("<h1>")
        expect(doc.to_html).to include("<p>Title</p>")
        expect(doc.to_html).to include("<p>Content</p>")
      end
    end

    describe "#add_link_attributes" do
      it "adds security attributes to links" do
        doc = Nokogiri::HTML::DocumentFragment.parse('<a href="https://example.com">Link</a>')
        result = helper.send(:add_link_attributes, doc)

        expect(result.to_html).to include('rel="nofollow noopener noreferrer"')
        expect(result.to_html).to include('target="_blank"')
      end

      it "preserves existing attributes" do
        doc = Nokogiri::HTML::DocumentFragment.parse('<a href="https://example.com" class="btn">Link</a>')
        result = helper.send(:add_link_attributes, doc)

        expect(result.to_html).to include('class="btn"')
        expect(result.to_html).to include('rel="nofollow noopener noreferrer"')
        expect(result.to_html).to include('target="_blank"')
      end
    end
  end
end
