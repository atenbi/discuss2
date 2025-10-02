require "rails_helper"

RSpec.describe "User Profiles", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "GET /profile" do
    context "when authenticated" do
      before { sign_in user }

      it "shows current user's profile" do
        get profile_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include(user.username)
      end

      it "paginates topics and posts" do
        create_list(:topic, 15, user: user)
        create_list(:post, 15, user: user)

        get profile_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include("pagy")
      end
    end
  end

  describe "GET /profile/:id" do
    context "when authenticated" do
      before { sign_in user }

      it "shows other user's profile" do
        get user_path(other_user)
        expect(response).to have_http_status(:success)
        expect(response.body).to include(other_user.username)
      end

      it "redirects when user not found" do
        get user_path(id: 99999)
        expect(response).to redirect_to(forum_topics_path)
        expect(flash[:alert]).to eq("User not found.")
      end
    end
  end

  describe "GET /profile/edit" do
    context "when authenticated" do
      before { sign_in user }

      it "renders edit form" do
        get edit_profile_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include("form")
        expect(response.body).to include(user.email)
      end
    end
  end

  describe "PATCH /profile" do
    context "when authenticated" do
      before { sign_in user }

      context "with valid parameters" do
        it "updates the user and redirects" do
          patch profile_path, params: {
            user: {
              email: "new@example.com",
              username: "newusername"
            }
          }

          expect(response).to redirect_to(profile_path)
          expect(user.username).to eq("newusername")
        end
      end

      context "with invalid parameters" do
        it "renders edit form with errors" do
          patch profile_path, params: {
            user: {
              email: "invalid-email"
            }
          }

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to include("form")
        end
      end
    end
  end

  describe "GET /profile/change_password" do
    context "when authenticated" do
      before { sign_in user }

      it "renders password edit form" do
        get change_password_profile_path
        expect(response).to have_http_status(:success)
        expect(response.body).to include("password")
      end
    end
  end

  describe "PATCH /profile/update_password" do
    context "when authenticated" do
      before { sign_in user }

      context "with valid password parameters" do
        it "updates password, signs user in and redirects" do
          patch update_password_profile_path, params: {
            user: {
              current_password: "password123",
              password: "newpassword123",
              password_confirmation: "newpassword123"
            }
          }

          expect(response).to redirect_to(profile_path)
          expect(flash[:notice]).to be_present
          get profile_path
          expect(response).to have_http_status(:success)
        end
      end

      context "with invalid password parameters" do
        it "renders password edit form with errors" do
          patch update_password_profile_path, params: {
            user: {
              current_password: "wrongpassword",
              password: "newpassword123",
              password_confirmation: "newpassword123"
            }
          }

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.body).to include("password")
        end
      end
    end
  end

  describe "when not authenticated" do
    it "redirects to sign in for profile" do
      get profile_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects to sign in for edit" do
      get edit_profile_path
      expect(response).to redirect_to(new_user_session_path)
    end

    it "redirects to sign in for password edit" do
      get change_password_profile_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
