class AddContentToForumTopics < ActiveRecord::Migration[8.0]
  def change
    add_column :forum_topics, :content, :text, null: false
  end
end
