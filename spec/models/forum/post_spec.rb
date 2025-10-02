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

require "rails_helper"

RSpec.describe Forum::Post, type: :model do
  let(:user) { create(:user, :forum_user) }
  let(:topic) { create(:topic, user: user) }

  context "validations" do
    it "is valid with valid attributes" do
      post = build(:post, user: user, topic: topic)
      expect(post).to be_valid
    end

    it "is invalid without content" do
      post = build(:post, user: user, topic: topic, content: nil)
      expect(post).not_to be_valid
      expect(post.errors[:content]).to include("can't be blank")
    end
  end

  context "associations" do
    it "belongs to a user" do
      post = build(:post, user: user, topic: topic)
      expect(post.user).to eq(user)
    end

    it "belongs to a topic" do
      post = build(:post, user: user, topic: topic)
      expect(post.topic).to eq(topic)
    end
  end

  context "counter caches" do
    it "increments topic.posts_count and user.posts_count after create" do
      expect {
        create(:post, user: user, topic: topic)
      }.to change { topic.reload.posts_count }.by(1)
       .and change { user.reload.posts_count }.by(1)
    end
  end

  context "activity timestamp" do
    it "updates topic.active_at after post is created" do
      post = create(:post, user: user, topic: topic)
      expect(topic.reload.active_at).to eq(post.updated_at)
    end

    it "updates topic.active_at after post is updated" do
      post = create(:post, user: user, topic: topic)
      post.update!(content: "Updated content")
      expect(topic.reload.active_at).to eq(post.updated_at)
    end
  end
end
