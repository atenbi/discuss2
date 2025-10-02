# == Schema Information
#
# Table name: forum_taggables
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tag_id     :bigint           not null
#  topic_id   :bigint           not null
#
# Indexes
#
#  index_forum_taggables_on_tag_id    (tag_id)
#  index_forum_taggables_on_topic_id  (topic_id)
#
# Foreign Keys
#
#  tag_id    (tag_id => forum_tags.id)
#  topic_id  (topic_id => forum_topics.id)
#
require "rails_helper"

RSpec.describe Forum::Taggable, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:category) { FactoryBot.create(:category) }
  let!(:topic) { FactoryBot.create(:topic, category: category, user: user) }
  let!(:tag) { FactoryBot.create(:tag) }

  describe "associations" do
    let!(:taggable) { FactoryBot.create(:taggable, topic: topic, tag: tag) }

    it "belongs to topic" do
      expect(taggable.topic).to eq(topic)
    end

    it "belongs to tag" do
      expect(taggable.tag).to eq(tag)
    end
  end

  describe "counter cache" do
    it "increments topic tags_count when taggable is created" do
      expect {
        FactoryBot.create(:taggable, topic: topic, tag: FactoryBot.create(:tag))
      }.to change { topic.reload.tags_count }.by(1)
    end

    it "increments tag topics_count when taggable is created" do
      expect {
        FactoryBot.create(:taggable, topic: FactoryBot.create(:topic, category: category, user: user), tag: tag)
      }.to change { tag.reload.topics_count }.by(1)
    end
  end
end
