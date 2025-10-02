class AddPinnedAtToForumTopics < ActiveRecord::Migration[8.0]
  def change
    add_column :forum_topics, :pinned_at, :datetime
  end
end
