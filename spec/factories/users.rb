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
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:username) { |n| "user#{n}" }
    password { "password123" }

    after(:build, &:skip_confirmation!)

    trait :admin do
      after(:create) { |user| user.add_role(:admin) }
    end

    trait :moderator do
      after(:create) { |user| user.add_role(:moderator) }
    end

    trait :forum_user do
      after(:create) { |user| user.add_role(:forum_user) }
    end
  end
end
