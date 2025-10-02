require "rails_helper"

RSpec.describe "User Confirmations", type: :request do
  let(:user) { create(:user, confirmed_at: nil, confirmation_token: 'test_token') }

  describe "GET /users/confirmation" do
    context "with valid confirmation token" do
      before do
        allow(User).to receive(:confirm_by_token).with('test_token').and_return(user)
        allow(user).to receive(:errors).and_return(double(empty?: true))
        allow(user).to receive(:confirmed?).and_return(true)
        allow(user).to receive(:update).with(state: :activated).and_return(true)
      end

      it "signs in the user and redirects to forum topics path" do
        get user_confirmation_path, params: { confirmation_token: 'test_token' }

        expect(response).to redirect_to(forum_topics_path)
        expect(flash[:notice]).to eq(I18n.t("devise.confirmations.confirmed"))
      end
    end

    context "with invalid confirmation token" do
      before do
        invalid_user = build(:user)
        allow(invalid_user).to receive(:errors).and_return(double(empty?: false))
        allow(User).to receive(:confirm_by_token).with('invalid_token').and_return(invalid_user)
      end

      it "redirects to new confirmation path with alert" do
        get user_confirmation_path, params: { confirmation_token: 'invalid_token' }

        expect(response).to redirect_to(new_user_confirmation_path(:user))
        expect(flash[:alert]).to eq("Something went wrong. Try to resend confirmation email.")
      end
    end
  end
end
