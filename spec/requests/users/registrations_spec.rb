require "rails_helper"

RSpec.describe "User Registrations", type: :request do
  describe "POST /users" do
    let(:valid_attributes) do
      {
        user: {
          username: "testuser",
          email: "test@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    context "successful registration redirection" do
      it "redirects to forum topics path after sign up" do
        post user_registration_path, params: valid_attributes

        expect(response).to redirect_to(forum_topics_path)
      end
    end

    context "spam detection" do
      it "redirects with spam alert when invisible_captcha detects spam" do
        spam_params = valid_attributes.merge({ subtitle: "spam content" })

        post user_registration_path, params: spam_params

        expect(response).to redirect_to(forum_topics_path)
        expect(flash[:alert]).to eq("Sorry, spambots are not allowed!")
      end
    end
  end
end
