module Forum
  class CategoryService
    def self.create_category!(name:, bg_color:)
      Category.create!(name: name, bg_color: bg_color)
    end

    def self.update_category!(category_id:, name:)
      category = Category.find(category_id)
      category.update!(name: name)
    end

    def self.delete_category!(category_id:)
      category = Category.find(category_id)
      category.destroy!
    end
  end
end
