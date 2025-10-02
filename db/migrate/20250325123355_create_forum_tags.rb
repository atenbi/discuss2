class CreateForumTags < ActiveRecord::Migration[8.0]
  def change
    create_table :forum_tags do |t|
      t.string :name, null: false
      t.string :slug, null: false

      t.timestamps
    end
    add_index :forum_tags, :slug, unique: true
  end
end
