require "rails_helper"

RSpec.describe Forum::PostPolicy, type: :policy do
  subject { described_class }

  let(:user)      { create(:user, :forum_user) }
  let(:owner)     { create(:user, :forum_user) }
  let(:other)     { create(:user, :forum_user) }
  let(:admin)     { create(:user, :admin) }
  let(:moderator) { create(:user, :moderator) }

  let!(:post) { create(:post, user: owner) }

  describe "Scope" do
    let!(:posts) { create_list(:post, 2) }

    subject { Pundit.policy_scope(user, Forum::Post) }

    it "returns all posts" do
      expect(subject).to match_array([ post ] + posts)
    end
  end

  permissions :update? do
    it "allows the owner" do
      expect(subject).to permit(owner, post)
    end

    it "allows an admin" do
      expect(subject).to permit(admin, post)
    end

    it "allows a moderator" do
      expect(subject).to permit(moderator, post)
    end

    it "denies other users" do
      expect(subject).not_to permit(other, post)
    end
  end

  permissions :destroy? do
    it "allows the owner" do
      expect(subject).to permit(owner, post)
    end

    it "allows an admin" do
      expect(subject).to permit(admin, post)
    end

    it "allows a moderator" do
      expect(subject).to permit(moderator, post)
    end

    it "denies other users" do
      expect(subject).not_to permit(other, post)
    end
  end

  permissions :edit? do
    it "allows the owner" do
      expect(subject).to permit(owner, post)
    end

    it "allows an admin" do
      expect(subject).to permit(admin, post)
    end

    it "allows a moderator" do
      expect(subject).to permit(moderator, post)
    end

    it "denies other users" do
      expect(subject).not_to permit(other, post)
    end
  end
end
