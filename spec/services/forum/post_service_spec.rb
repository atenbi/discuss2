require "rails_helper"

RSpec.describe Forum::PostService do
  let(:user) { create(:user, :forum_user) }
  let(:category) { create(:category) }
  let(:topic) { create(:topic, user: user, category: category) }
  let(:content) { "Test post content" }

  describe ".create_post!" do
    it "creates a new post" do
      expect {
        described_class.create_post!(user_id: user.id, topic_id: topic.id, content: content)
      }.to change(Forum::Post, :count).by(1)

      post = Forum::Post.last
      expect(post.user_id).to eq(user.id)
      expect(post.topic_id).to eq(topic.id)
      expect(post.content).to eq(content)
    end

    it "raises error when user not found" do
      expect {
        described_class.create_post!(user_id: -1, topic_id: topic.id, content: content)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "raises error when topic not found" do
      expect {
        described_class.create_post!(user_id: user.id, topic_id: -1, content: content)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe ".update_post!" do
    let(:post) { create(:post, user: user, topic: topic, content: "Original content") }
    let(:new_content) { "Updated content" }

    it "updates the post content" do
      described_class.update_post!(post_id: post.id, content: new_content)

      post.reload
      expect(post.content).to eq(new_content)
    end

    it "raises error when post not found" do
      expect {
        described_class.update_post!(post_id: -1, content: new_content)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe ".delete_post!" do
    let!(:post) { create(:post, user: user, topic: topic) }

    it "deletes the post" do
      expect {
        described_class.delete_post!(post_id: post.id)
      }.to change(Forum::Post, :count).by(-1)
    end

    it "raises error when post not found" do
      expect {
        described_class.delete_post!(post_id: -1)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
