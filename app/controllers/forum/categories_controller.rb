module Forum
  class CategoriesController < ApplicationController
    def index
      @pagy, @categories = pagy(Category.order(name: :asc), limit: 6)

      @select_default_item = Shared::CustomSelectComponent::Item.new("", "Categories")
      @select_items = Category.all.map { |category| Shared::CustomSelectComponent::Item.new(category.slug, category.name, category.bg_color) }
      @category = Category.friendly.find_by(slug: params[:category]) if params[:category].present?

      set_meta_tags(
        title: "Categories",
        description: "Browse all discussion categories in our community forum",
        keywords: "categories, forum, discussion, community",
        canonical: forum_categories_url
      )
    end
  end
end
