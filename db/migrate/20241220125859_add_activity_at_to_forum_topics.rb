class AddActivityAtToForumTopics < ActiveRecord::Migration[8.0]
  def change
    add_column :forum_topics, :activity_at, :datetime, null: false, default: -> { "CURRENT_TIMESTAMP" }
    add_index  :forum_topics, :activity_at
  end
end
