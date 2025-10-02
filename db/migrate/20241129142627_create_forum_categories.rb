class CreateForumCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :forum_categories do |t|
      t.string :name, null: false
      t.string :slug, null: false

      t.timestamps
    end
    add_index :forum_categories, :slug, unique: true
  end
end
