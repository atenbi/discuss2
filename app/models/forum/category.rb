# == Schema Information
#
# Table name: forum_categories
#
#  id           :integer          not null, primary key
#  bg_color     :string           not null
#  name         :string           not null
#  slug         :string           not null
#  topics_count :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_forum_categories_on_slug  (slug) UNIQUE
#

class Forum::Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :topics, dependent: :nullify

  validates :name, presence: true, uniqueness: true
  validates :bg_color, presence: true, format: {
    with: /\A#(?:[0-9a-fA-F]{3}){1,2}\z/,
    message: "must be a valid hex color code (e.g. #FFF or #FFFFFF)"
  }

  private

  def should_generate_new_friendly_id?
    name_changed?
  end
end
