class AddPostsCountToForumTopics < ActiveRecord::Migration[8.0]
  def change
    add_column :forum_topics, :posts_count, :integer, default: 0, null: false
    add_index :forum_topics, :posts_count
  end
end
