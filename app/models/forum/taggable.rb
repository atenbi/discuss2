# == Schema Information
#
# Table name: forum_taggables
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tag_id     :bigint           not null
#  topic_id   :bigint           not null
#
# Indexes
#
#  index_forum_taggables_on_tag_id    (tag_id)
#  index_forum_taggables_on_topic_id  (topic_id)
#
# Foreign Keys
#
#  tag_id    (tag_id => forum_tags.id)
#  topic_id  (topic_id => forum_topics.id)
#

class Forum::Taggable < ApplicationRecord
  belongs_to :topic, counter_cache: :tags_count
  belongs_to :tag, counter_cache: :topics_count
end
