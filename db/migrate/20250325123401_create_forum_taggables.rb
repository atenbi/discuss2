class CreateForumTaggables < ActiveRecord::Migration[8.0]
  def change
    create_table :forum_taggables do |t|
      t.references :topic, null: false, foreign_key: { to_table: :forum_topics }
      t.references :tag, null: false, foreign_key: { to_table: :forum_tags }

      t.timestamps
    end
  end
end
