require "rails_helper"

RSpec.describe "Forum::Topics", type: :request do
  let(:user) { create(:user, :forum_user) }
  let(:user2) { create(:user, :forum_user) }
  let(:admin) { create(:user, :admin) }
  let(:category) { create(:category) }
  let(:tag) { create(:tag) }
  let(:topic) { create(:topic, user: user, category: category) }

  describe "GET /forum/topics" do
    it "returns http success" do
      get forum_topics_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /forum/topics/:id" do
    it "returns http success" do
      get forum_topic_path(topic)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /forum/topics/new" do
    context "when not signed in" do
      it "redirects to sign in" do
        get new_forum_topic_path
        expect(response).to have_http_status(:found)
      end
    end

    context "when signed in" do
      before { sign_in user }

      it "returns http success" do
        get new_forum_topic_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "POST /forum/topics" do
    let(:valid_params) do
      {
        forum_topic: {
          user_id: user.id,
          category_id: category.id,
          tag_ids: [ tag.id ],
          title: "Test Topic",
          content: "Some content"
        }
      }
    end

    context "when not signed in" do
      it "redirects to sign in" do
        post forum_topics_path, params: valid_params
        expect(response).to have_http_status(:found)
      end
    end

    context "when signed in" do
      it "redirects after creation" do
        sign_in user

        post forum_topics_path, params: valid_params
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe "GET /forum/topics/:id/edit" do
    context "when not signed in" do
      it "redirects to sign in" do
        get edit_forum_topic_path(topic)
        expect(response).to have_http_status(:found)
      end
    end

    context "when signed in as topics owner" do
      before { sign_in user }

      it "redirects to root" do
        get edit_forum_topic_path(topic)
        expect(response).to have_http_status(:ok)
      end
    end

    context "when signed in as forum user" do
      before { sign_in user2 }

      it "redirects to root" do
        get edit_forum_topic_path(topic)
        expect(response).to have_http_status(:found)
      end
    end

    context "when signed in as admin" do
      before { sign_in admin }

      it "returns http success" do
        get edit_forum_topic_path(topic)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "PATCH /forum/topics/:id" do
    let(:update_params) do
      { forum_topic: { title: "Updated", content: "Updated content", category_id: category.id, tag_ids: [] } }
    end

    context "when signed in as admin" do
      before { sign_in admin }

      it "redirects after update" do
        patch forum_topic_path(topic), params: update_params
        expect(response).to have_http_status(:found)
      end
    end

    context "when not admin" do
      before { sign_in user }

      it "redirects to root" do
        patch forum_topic_path(topic), params: update_params
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe "PATCH /forum/topics/:id/update_pinned" do
    before { sign_in admin }

    it "redirects after pin" do
      patch update_pinned_forum_topic_path(topic), params: { pin: "true" }
      expect(response).to have_http_status(:found)
    end

    it "redirects after unpin" do
      topic.update!(pinned_at: Time.current)
      patch update_pinned_forum_topic_path(topic), params: { pin: "false" }
      expect(response).to have_http_status(:found)
    end
  end

  describe "DELETE /forum/topics/:id" do
    before { sign_in admin }
    let!(:topic_to_delete) { create(:topic, category: category, user: user) }

    it "redirects after delete" do
      delete forum_topic_path(topic_to_delete)
      expect(response).to have_http_status(:found)
    end
  end
end
