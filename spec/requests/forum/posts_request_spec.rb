require "rails_helper"

RSpec.describe "Forum::Posts", type: :request do
  let(:user) { create(:user, :forum_user) }
  let(:user2) { create(:user, :forum_user) }
  let(:admin) { create(:user, :admin) }
  let(:topic) { create(:topic) }
  let(:post_record) { create(:post, topic: topic, user: user) }

  describe "POST /forum/topics/:topic_id/posts" do
    let(:valid_params) { { forum_post: { content: "Test content" } } }

    context "when user is not signed in" do
      it "redirects to sign in" do
        post forum_topic_posts_path(topic), params: valid_params
        expect(response).to have_http_status(:found)
      end
    end

    context "when user is signed in" do
      before { sign_in user }

      it "redirects after creation" do
        post forum_topic_posts_path(topic), params: valid_params
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe "GET /forum/topics/:topic_id/posts/:id/edit" do
    context "when admin" do
      before { sign_in admin }

      it "returns success" do
        get edit_forum_topic_post_path(topic, post_record)
        expect(response).to have_http_status(:ok)
      end
    end

    context "when post's owner" do
      before { sign_in user }

      it "returns success" do
        get edit_forum_topic_post_path(topic, post_record)
        expect(response).to have_http_status(:ok)
      end
    end

    context "when forum user" do
      before { sign_in user2 }

      it "redirects" do
        get edit_forum_topic_post_path(topic, post_record)
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe "PATCH /forum/topics/:topic_id/posts/:id" do
    let(:update_params) { { forum_post: { content: "Updated content" } } }

    context "when admin" do
      before { sign_in admin }

      it "redirects after update" do
        patch forum_topic_post_path(topic, post_record), params: update_params
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe "DELETE /forum/topics/:topic_id/posts/:id" do
    context "when admin" do
      before { sign_in admin }

      it "redirects after delete" do
        delete forum_topic_post_path(topic, post_record)
        expect(response).to have_http_status(:found)
      end
    end
  end
end
