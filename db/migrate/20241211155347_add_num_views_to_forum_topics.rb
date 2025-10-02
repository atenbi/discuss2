class AddNumViewsToForumTopics < ActiveRecord::Migration[8.0]
  def change
    add_column :forum_topics, :num_views, :integer, default: 0
  end
end
