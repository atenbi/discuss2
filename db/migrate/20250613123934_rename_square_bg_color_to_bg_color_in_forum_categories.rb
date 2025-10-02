class RenameSquareBgColorToBgColorInForumCategories < ActiveRecord::Migration[8.0]
  def change
    rename_column :forum_categories, :square_bg_color, :bg_color
  end
end
