require "rails_helper"

RSpec.describe UserSoftDeletionService do
  let(:user) { create(:user, username: "testuser", email: "test@example.com", slug: "testuser") }

  describe ".call" do
    context "when user exists" do
      it "soft deletes user and anonymizes all columns" do
        username_before_deletion = user.username
        email_before_deletion = user.email
        slug_before_deletion = user.slug

        result = described_class.call(user_id: user.id)
        expect(result).to be true

        user.reload

        expect(user.state).to eq("deleted")
        expect(user.username).not_to eq(username_before_deletion)
        expect(user.username).to match(/^deleted_user_#{user.id}_\d+$/)
        expect(user.email).not_to eq(email_before_deletion)
        expect(user.email).to match(/^deleted_#{user.id}_\d+@example\.com$/)
        expect(user.slug).to be_nil
        expect(user.slug).not_to eq(slug_before_deletion)
        expect(user.avatar_bg_color).to eq("#6b7280")
      end
    end

    context "when user doesn't exist" do
      it "returns false for non-existent user ID" do
        result = described_class.call(user_id: 99999)

        expect(result).to be false
      end

      it "returns false for nil user ID" do
        result = described_class.call(user_id: nil)

        expect(result).to be false
      end
    end
  end
end
