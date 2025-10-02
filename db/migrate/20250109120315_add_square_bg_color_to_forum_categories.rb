class AddSquareBgColorToForumCategories < ActiveRecord::Migration[8.0]
  def change
    add_column :forum_categories, :square_bg_color, :string, null: false
  end
end
