class AddTitleLengthLimitToForumTopics < ActiveRecord::Migration[8.0]
  def change
    change_column :forum_topics, :title, :string, limit: 255
  end
end
