require "rails_helper"

RSpec.describe Forum::TopicService do
  let(:user) { create(:user, :forum_user) }
  let(:category) { create(:category) }
  let(:tag) { create(:tag) }

  describe ".create_topic!" do
    let(:valid_attributes) do
      {
        user_id: user.id,
        category_id: category.id,
        title: "Test Topic",
        content: "Test Content"
      }
    end

    context "with valid attributes" do
      it "creates a new topic" do
        expect {
          described_class.create_topic!(**valid_attributes)
        }.to change(Forum::Topic, :count).by(1)

        topic = Forum::Topic.last
        expect(topic.user).to eq(user)
        expect(topic.category).to eq(category)
        expect(topic.title).to eq("Test Topic")
        expect(topic.content).to eq("Test Content")
      end

      it "creates a topic with tags" do
        expect {
          described_class.create_topic!(**valid_attributes, tag_ids: [ tag.id ])
        }.to change(Forum::Taggable, :count).by(1)

        topic = Forum::Topic.last
        expect(topic.tags).to include(tag)
      end
    end

    context "with invalid attributes" do
      let(:invalid_attributes) { valid_attributes }

      it "raises error when user not found" do
        expect {
          described_class.create_topic!(**invalid_attributes.merge(user_id: -1))
        }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "creates topic with nil category when category not found" do
        topic = described_class.create_topic!(**invalid_attributes.merge(category_id: -1))
        expect(topic.category).to be_nil
      end
    end
  end

  describe ".update_topic!" do
    let!(:topic) { create(:topic, user: user, category: category) }
    let(:new_category) { create(:category) }

    it "updates the topic" do
      new_title = "Updated Title"
      new_content = "Updated Content"

      updated_topic = described_class.update_topic!(
        user_id: user.id,
        category_id: new_category.id,
        topic_id: topic.id,
        title: new_title,
        content: new_content
      )

      expect(updated_topic.title).to eq(new_title)
      expect(updated_topic.content).to eq(new_content)
      expect(updated_topic.category).to eq(new_category)
    end

    it "updates topic tags" do
      new_tag = create(:tag)

      expect {
        described_class.update_topic!(
          user_id: user.id,
          category_id: category.id,
          topic_id: topic.id,
          title: topic.title,
          content: topic.content,
          tag_ids: [ new_tag.id ]
        )
      }.to change(Forum::Taggable, :count).by(1)

      topic.reload
      expect(topic.tags).to include(new_tag)
    end

    it "raises error when topic not found" do
      expect {
        described_class.update_topic!(
          user_id: user.id,
          category_id: category.id,
          topic_id: -1,
          title: "Title",
          content: "Content"
        )
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "updates topic with nil category when category not found" do
      updated_topic = described_class.update_topic!(
        user_id: user.id,
        category_id: -1,
        topic_id: topic.id,
        title: "Updated Title",
        content: "Updated Content"
      )

      expect(updated_topic.category).to be_nil
    end
  end

  describe ".delete_topic!" do
    let!(:topic) { create(:topic, user: user, category: category) }

    it "deletes the topic" do
      expect {
        described_class.delete_topic!(topic_id: topic.id)
      }.to change(Forum::Topic, :count).by(-1)
    end

    it "raises error when topic not found" do
      expect {
        described_class.delete_topic!(topic_id: -1)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
