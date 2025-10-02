# == Schema Information
#
# Table name: forum_tags
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  slug         :string           not null
#  topics_count :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_forum_tags_on_slug          (slug) UNIQUE
#  index_forum_tags_on_topics_count  (topics_count)
#

module Forum
  class Tag < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged

    has_many :taggables, dependent: :destroy
    has_many :topics, through: :taggables

    validates :name, presence: true, uniqueness: true

    private

    def should_generate_new_friendly_id?
      name_changed?
    end

    def self.ransackable_attributes(auth_object = nil)
      [ "name", "slug", "topics_count" ]
    end

    def self.ransackable_associations(auth_object = nil)
      [ "taggables", "topics" ]
    end
  end
end
