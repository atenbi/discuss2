class CreateForumPosts < ActiveRecord::Migration[8.0]
  def change
    create_table :forum_posts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: { to_table: :forum_topics }
      t.text :content, null: false

      t.timestamps
    end
  end
end
