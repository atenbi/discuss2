module Forum
  class TagsController < ApplicationController
    def index
      @q = Tag.ransack(params[:q])
      @pagy, @tags = pagy(@q.result, limit: 60)

      set_meta_tags(
        title: "Tags",
        description: "Browse all discussion topics by tags in our community forum",
        keywords: "tags, topics, forum, discussion, community,  discuss²",
        canonical: forum_tags_url
      )
    end
  end
end
