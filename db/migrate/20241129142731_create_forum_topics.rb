class CreateForumTopics < ActiveRecord::Migration[8.0]
  def change
    create_table :forum_topics do |t|
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: { to_table: :forum_categories }
      t.string :title, null: false
      t.string :slug, null: false

      t.timestamps
    end
    add_index :forum_topics, :slug, unique: true
  end
end
