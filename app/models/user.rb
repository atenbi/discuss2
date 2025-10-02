# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  avatar_bg_color        :string           not null
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  posts_count            :integer          default(0), not null
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  slug                   :string
#  state                  :integer          default("registered"), not null
#  topics_count           :integer          default(0), not null
#  uid                    :string
#  unconfirmed_email      :string
#  username               :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug) UNIQUE
#  index_users_on_state                 (state)
#  index_users_on_username              (username) UNIQUE
#

class User < ApplicationRecord
  rolify
  extend FriendlyId
  friendly_id :username, use: :slugged

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [ :google_oauth2 ]

  before_create :assign_avatar_bg_color
  after_create :assign_default_role

  has_many :topics, class_name: "Forum::Topic", dependent: :nullify
  has_many :posts, class_name: "Forum::Post", dependent: :nullify

  validates :username, presence: true, uniqueness: true

  enum :state, {
    registered: 0,
    semiactivated: 1,
    activated: 2,
    deactivated: 3,
    deleted: 4
  }

  scope :admins, -> { with_role(:admin) }
  scope :forum_users, -> { with_role(:forum_user) }
  scope :moderators, -> { with_role(:moderator) }

  def active_for_authentication?
    super && !deleted?
  end

  def self.from_omniauth(auth)
    username = generate_unique_username(auth.info.name)
    create_with(uid: auth.uid, provider: auth.provider,
                username: username,
                password: Devise.friendly_token[0, 20]).find_or_create_by!(email: auth.info.email)
  end

  private

  def should_generate_new_friendly_id?
    username_changed? && !deleted?
  end

  def self.generate_unique_username(base_name)
    username = base_name.to_s.strip.gsub(/\s+/, "_").gsub(/[^a-zA-Z0-9_-]/, "")
    username = username.presence || "user"

    return username unless exists?(username: username)

    counter = 1
    while exists?(username: "#{username}#{counter}")
      counter += 1
    end
    "#{username}#{counter}"
  end

  def assign_default_role
    add_role :forum_user
  end

  def assign_avatar_bg_color
    colors = [
      "#7FB8A4", "#7D9EC0", "#6C87B5", "#5A6B8F", "#7A76B7", "#9D8AC0",
      "#8B6DA6", "#A66DA6", "#C07A7A", "#9E6060", "#C08F6D", "#C0A67D",
      "#B5AD6C", "#C0BC7D", "#9EB56C", "#7DA67D", "#6CA69E", "#6D9EB5",
      "#6D96B5", "#5A6B8F", "#7D6C9E", "#8F5A7D", "#8F5A5A", "#5A8F6C",
      "#7D8F5A", "#8F9CA6", "#7D8595", "#4A5A6B", "#8F5A6B", "#8F6C5A"
    ]
    self.avatar_bg_color = colors.sample
  end
end
