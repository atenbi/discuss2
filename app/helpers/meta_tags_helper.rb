module MetaTagsHelper
    def render_meta_tags
      return unless @meta_tags.is_a?(Hash)

      safe_join([
        standard_meta_tags,
        open_graph_tags
      ].compact, "\n")
    end

    private

    def standard_meta_tags
      [
        tag.meta(name: "description", content: @meta_tags[:description]),
        tag.meta(name: "keywords", content: @meta_tags[:keywords]),
        tag.link(rel: "canonical", href: @meta_tags[:canonical])
      ].select(&:present?)
    end

    def open_graph_tags
      [
        tag.meta(property: "og:site_name", content: "discuss²"),
        tag.meta(property: "og:title", content: @meta_tags[:title] || "discuss²"),
        tag.meta(property: "og:description", content: @meta_tags[:description]),
        tag.meta(property: "og:url", content: request.original_url),
        tag.meta(property: "og:type", content: @meta_tags[:type] || "website"),
        tag.meta(property: "og:image", content: @meta_tags[:image])
      ].select(&:present?)
    end
end
