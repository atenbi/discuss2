class AddTagsCountToForumTopics < ActiveRecord::Migration[8.0]
  def change
    add_column :forum_topics, :tags_count, :integer, default: 0, null: false
    add_index :forum_topics, :tags_count

    reversible do |dir|
      dir.up do
        Forum::Topic.find_each do |topic|
          Forum::Topic.reset_counters(topic.id, :tags)
        end
      end
    end
  end
end
