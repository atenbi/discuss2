class AddTopicsCountToForumTags < ActiveRecord::Migration[8.0]
  def change
    add_column :forum_tags, :topics_count, :integer, default: 0, null: false
    add_index :forum_tags, :topics_count

    reversible do |dir|
      dir.up do
        Forum::Tag.find_each do |tag|
          Forum::Tag.reset_counters(tag.id, :topics)
        end
      end
    end
  end
end
