class RenameActivityAtToActiveAtInForumTopic < ActiveRecord::Migration[8.0]
  def change
    rename_column :forum_topics, :activity_at, :active_at
  end
end
