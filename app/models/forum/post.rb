# == Schema Information
#
# Table name: forum_posts
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_forum_posts_on_topic_id  (topic_id)
#  index_forum_posts_on_user_id   (user_id)
#
# Foreign Keys
#
#  topic_id  (topic_id => forum_topics.id)
#  user_id   (user_id => users.id)
#

class Forum::Post < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :topic, counter_cache: true

  validates :content, presence: true

  after_commit :update_topic_active_at, on: %i[create update]

  private

  def update_topic_active_at
    topic.update_column(:active_at, updated_at)
  end
end
