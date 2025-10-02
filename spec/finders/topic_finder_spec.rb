require "rails_helper"

RSpec.describe TopicFinder, type: :service do
  let!(:category1) { create(:category, name: "General", slug: "general") }
  let!(:category2) { create(:category, name: "News", slug: "news") }

  let!(:tag_ramen) { create(:tag, name: "Ramen", slug: "ramen") }
  let!(:tag_anime) { create(:tag, name: "Anime", slug: "anime") }

  let!(:topic1) { create(:topic, title: "First Topic", content: "Hello World", category: category1, num_views: 5, posts_count: 1) }
  let!(:topic2) { create(:topic, title: "Second Topic", content: "Latest News", category: category1, num_views: 10, posts_count: 3) }
  let!(:topic3) { create(:topic, title: "Third Topic", content: "Old Stuff", category: category2, num_views: 2, posts_count: 0) }
  let!(:topic4) { create(:topic, title: "Ramen Tag Topic", content: "Learn Ramen", category: category1, num_views: 8, posts_count: 5) }
  let!(:topic5) { create(:topic, title: "Anime Tag Topic", content: "Learn Anime", category: category1, num_views: 20, posts_count: 2) }

  before do
    topic1.update_columns(active_at: 2.days.ago)
    topic2.update_columns(active_at: 1.day.ago, pinned_at: Time.current)
    topic3.update_columns(active_at: 3.days.ago)
    topic4.update_columns(active_at: 4.days.ago)
    topic5.update_columns(active_at: 5.days.ago)

    create(:taggable, topic: topic4, tag: tag_ramen)
    create(:taggable, topic: topic5, tag: tag_anime)
  end

  describe "#perform" do
    context "default behavior" do
      it "returns all topics sorted by pinned first then activity" do
        result = TopicFinder.perform(ransack_params: {}, params: {})

        expect(result).to eq([ topic2, topic1, topic3, topic4, topic5 ])
      end
    end

    context "filtering by category" do
      it "returns only topics from the specified category" do
        result = TopicFinder.perform(ransack_params: { category_id_eq: category2.id }, params: {})

        expect(result).to contain_exactly(topic3)
      end
    end

    context "filtering by tag" do
      it "returns only topics tagged with Ramen" do
        result = TopicFinder.perform(ransack_params: {}, params: { tag: "ramen" })

        expect(result).to contain_exactly(topic4)
      end

      it "returns only topics tagged with Anime" do
        result = TopicFinder.perform(ransack_params: {}, params: { tag: "anime" })

        expect(result).to contain_exactly(topic5)
      end
    end

    context "searching by title or content" do
      it "finds topics by title" do
        result = TopicFinder.perform(ransack_params: { title_cont: "First" }, params: {})

        expect(result).to contain_exactly(topic1)
      end
    end

    context "sorting" do
      it "sorts by number of replies (posts_count desc)" do
        result = TopicFinder.perform(ransack_params: { s: "posts_count desc" }, params: {})

        expect(result.first).to eq(topic2) # pinned first
        expect(result[1..]).to eq([ topic4, topic5, topic1, topic3 ])
      end

      it "sorts by number of views (num_views desc)" do
        result = TopicFinder.perform(ransack_params: { s: "num_views desc" }, params: {})

        expect(result.first).to eq(topic2) # pinned first
        expect(result[1..]).to eq([ topic5, topic4, topic1, topic3 ])
      end

      it "sorts by active_at descending" do
        result = TopicFinder.perform(ransack_params: { s: "active_at desc" }, params: {})

        expect(result.first).to eq(topic2) # pinned first
        expect(result[1..]).to eq([ topic1, topic3, topic4, topic5 ])
      end
    end
  end
end
