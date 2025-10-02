# == Schema Information
#
# Table name: forum_topics
#
#  id          :integer          not null, primary key
#  active_at   :datetime         not null
#  content     :text             not null
#  num_views   :integer          default(0)
#  pinned_at   :datetime
#  posts_count :integer          default(0), not null
#  slug        :string           not null
#  tags_count  :integer          default(0), not null
#  title       :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_forum_topics_on_active_at    (active_at)
#  index_forum_topics_on_category_id  (category_id)
#  index_forum_topics_on_posts_count  (posts_count)
#  index_forum_topics_on_slug         (slug) UNIQUE
#  index_forum_topics_on_tags_count   (tags_count)
#  index_forum_topics_on_user_id      (user_id)
#
# Foreign Keys
#
#  category_id  (category_id => forum_categories.id)
#  user_id      (user_id => users.id)
#

class Forum::Topic < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user, counter_cache: true
  belongs_to :category, counter_cache: true
  has_many :taggables, dependent: :destroy
  has_many :tags, through: :taggables
  has_many :posts, dependent: :destroy

  validates :title, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :content, presence: true
  validates :category, presence: true

  validate :validate_maximum_tags_per_topic

  after_commit :update_active_at, on: %i[create update]

  def pinned?
    pinned_at.present?
  end

  def pin!
    update!(pinned_at: Time.current)
  end

  def unpin!
    update!(pinned_at: nil)
  end

  def participants
    User.where(id: [ user_id ] + posts.pluck(:user_id))
  end

  private

  def should_generate_new_friendly_id?
    title_changed?
  end

  def update_active_at
    update_column(:active_at, updated_at)
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[title category_id num_views posts_count active_at created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[category posts user]
  end

  private

  def validate_maximum_tags_per_topic
    if tags_count > 5
      errors.add(:base, "A topic can have at most 5 tags")
    end
  end
end
