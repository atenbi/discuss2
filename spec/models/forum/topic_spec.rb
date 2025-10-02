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
require "rails_helper"

RSpec.describe Forum::Topic, type: :model do
  let(:user)     { create(:user, :forum_user) }
  let(:category) { create(:category) }

  context "validations" do
    it "is valid with title and content" do
      topic = build(:topic, user: user, category: category)
      expect(topic).to be_valid
    end

    it "is invalid without a title" do
      topic = build(:topic, title: nil)
      expect(topic).not_to be_valid
      expect(topic.errors[:title]).to include("can't be blank")
    end

    it "is invalid without content" do
      topic = build(:topic, content: nil)
      expect(topic).not_to be_valid
      expect(topic.errors[:content]).to include("can't be blank")
    end

    it "is invalid with a duplicate title" do
      create(:topic, title: "Rails 7")
      duplicate = build(:topic, title: "Rails 7")
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:title]).to include("has already been taken")
    end

    it "is invalid if title is over 255 characters" do
      long_title = "a" * 256
      topic = build(:topic, title: long_title)
      expect(topic).not_to be_valid
      expect(topic.errors[:title]).to include("is too long (maximum is 255 characters)")
    end

    it "is valid with up to 5 tags" do
      topic = build(:topic, tags_count: 5)
      expect(topic).to be_valid
    end

    it "is invalid with more than 5 tags" do
      topic = build(:topic, tags_count: 6)
      expect(topic).not_to be_valid
      expect(topic.errors[:base]).to include("A topic can have at most 5 tags")
    end
  end

  context "associations" do
    it "belongs to a user and a category" do
      topic = create(:topic, user: user, category: category)
      expect(topic.user).to eq(user)
      expect(topic.category).to eq(category)
    end

    it "has many posts and destroys them on delete" do
      topic = create(:topic)
      create_list(:post, 3, topic: topic)
      expect { topic.destroy }.to change { Forum::Post.count }.by(-3)
    end

    it "has many tags through taggables" do
      tag = create(:tag)
      topic = create(:topic)
      create(:taggable, topic: topic, tag: tag)

      expect(topic.tags).to include(tag)
    end
  end

  context "pinning" do
    let(:topic) { create(:topic) }

    it "is not pinned by default" do
      expect(topic.pinned?).to be false
    end

    it "can be pinned" do
      topic.pin!
      expect(topic.pinned?).to be true
    end

    it "can be unpinned" do
      topic.update!(pinned_at: Time.current)
      topic.unpin!
      expect(topic.pinned?).to be false
    end
  end

  context "#participants" do
    it "includes the topic author and all post authors" do
      other_user = create(:user)
      topic = create(:topic, user: user)
      create(:post, topic: topic, user: other_user)

      expect(topic.participants).to match_array([ user, other_user ])
    end
  end

  describe "ransack configuration" do
    describe ".ransackable_associations" do
      it "returns the allowed searchable associations" do
        expected_associations = %w[category posts user]
        expect(Forum::Topic.ransackable_associations).to match_array(expected_associations)
      end

      it "accepts auth_object parameter" do
        expected_associations = %w[category posts user]
        expect(Forum::Topic.ransackable_associations).to match_array(expected_associations)
      end
    end
  end
end
