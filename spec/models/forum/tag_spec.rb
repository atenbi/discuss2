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

require "rails_helper"

RSpec.describe Forum::Tag, type: :model do
  describe "validations" do
    it "is valid with a name" do
      tag = build(:tag)
      expect(tag).to be_valid
    end

    it "is invalid without a name" do
      tag = build(:tag, name: nil)
      expect(tag).not_to be_valid
      expect(tag.errors[:name]).to include("can't be blank")
    end

    it "is invalid with a duplicate name" do
      create(:tag, name: "Ruby")
      tag = build(:tag, name: "Ruby")
      expect(tag).not_to be_valid
      expect(tag.errors[:name]).to include("has already been taken")
    end
  end

  describe "associations" do
    it "has many taggables" do
      tag = create(:tag)
      expect(tag.taggables).to be_empty
    end

    it "has many topics through taggables" do
      tag = create(:tag)
      topic = create(:topic)
      create(:taggable, tag: tag, topic: topic)

      expect(tag.topics).to include(topic)
    end
  end

  describe "#topics_count" do
    it "returns the number of associated topics" do
      tag = create(:tag)
      create_list(:taggable, 3, tag: tag)

      expect(tag.topics_count).to eq(3)
    end
  end

  describe "ransack configuration" do
    describe ".ransackable_attributes" do
      it "returns the allowed searchable attributes" do
        expected_attributes = [ "name", "slug", "topics_count" ]
        expect(Forum::Tag.ransackable_attributes).to match_array(expected_attributes)
      end

      it "accepts auth_object parameter" do
        expected_attributes = [ "name", "slug", "topics_count" ]
        expect(Forum::Tag.ransackable_attributes).to match_array(expected_attributes)
      end
    end

    describe ".ransackable_associations" do
      it "returns the allowed searchable associations" do
        expected_associations = [ "taggables", "topics" ]
        expect(Forum::Tag.ransackable_associations).to match_array(expected_associations)
      end

      it "accepts auth_object parameter" do
        expected_associations = [ "taggables", "topics" ]
        expect(Forum::Tag.ransackable_associations).to match_array(expected_associations)
      end
    end
  end
end
