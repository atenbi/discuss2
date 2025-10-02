class AddTopicsCountToForumCategories < ActiveRecord::Migration[8.0]
  def change
    add_column :forum_categories, :topics_count, :integer, default: 0

    reversible do |dir|
      dir.up do
        Forum::Category.find_each do |category|
          Forum::Category.reset_counters(category.id, :topics)
        end
      end
    end
  end
end
