require "rails_helper"

RSpec.describe "User Sessions", type: :request do
  let(:user) { create(:user) }

  describe "POST /users/sign_in" do
    it "redirects to forum topics path after successful sign in" do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      expect(response).to redirect_to(forum_topics_path)
    end
  end

  describe "DELETE /users/sign_out" do
    before { sign_in user }

    it "redirects to forum topics path after sign out" do
      delete destroy_user_session_path
      expect(response).to redirect_to(forum_topics_path)
    end
  end
end
