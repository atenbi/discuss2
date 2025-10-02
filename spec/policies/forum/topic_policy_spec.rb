require "rails_helper"

RSpec.describe Forum::TopicPolicy, type: :policy do
  subject { described_class }

  let(:user)      { create(:user, :forum_user) }
  let(:owner)     { create(:user, :forum_user) }
  let(:other)     { create(:user, :forum_user) }
  let(:admin)     { create(:user, :admin) }
  let(:moderator) { create(:user, :moderator) }

  let!(:topic) { create(:topic, user: owner) }

  describe "Scope" do
    let!(:topics) { create_list(:topic, 2) }

    subject { Pundit.policy_scope(user, Forum::Topic) }

    it "returns all topics" do
      expect(subject).to match_array([ topic ] + topics)
    end
  end

  permissions :update? do
    it "allows the owner" do
      expect(subject).to permit(owner, topic)
    end

    it "allows an admin" do
      expect(subject).to permit(admin, topic)
    end

    it "allows a moderator" do
      expect(subject).to permit(moderator, topic)
    end

    it "denies other users" do
      expect(subject).not_to permit(other, topic)
    end
  end

  permissions :update_pinned? do
    it "denies the owner" do
      expect(subject).not_to permit(owner, topic)
    end

    it "allows an admin" do
      expect(subject).to permit(admin, topic)
    end

    it "allows a moderator" do
      expect(subject).to permit(moderator, topic)
    end

    it "denies other users" do
      expect(subject).not_to permit(other, topic)
    end
  end

  permissions :destroy? do
    it "denies the owner" do
      expect(subject).not_to permit(owner, topic)
    end

    it "allows an admin" do
      expect(subject).to permit(admin, topic)
    end

    it "allows a moderator" do
      expect(subject).to permit(moderator, topic)
    end

    it "denies other users" do
      expect(subject).not_to permit(other, topic)
    end
  end

  permissions :edit? do
    it "allows the owner" do
      expect(subject).to permit(owner, topic)
    end

    it "allows an admin" do
      expect(subject).to permit(admin, topic)
    end

    it "allows a moderator" do
      expect(subject).to permit(moderator, topic)
    end

    it "denies other users" do
      expect(subject).not_to permit(other, topic)
    end
  end
end
