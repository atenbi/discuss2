require "rails_helper"

RSpec.describe Profile::HeaderComponent, type: :component do
  let(:user) { create(:user, username: "john_doe", created_at: Date.new(2023, 6, 15)) }
  let(:component) { described_class.new(user: user) }

  describe "rendering" do
    subject { render_inline(component) }

    it "displays the username" do
      expect(subject).to have_content("john_doe")
    end

    it "displays the user avatar" do
      expect(subject).to have_content("J")
    end

    it "displays member since date" do
      expect(subject).to have_content("Member since")
      expect(subject).to have_content("June 15, 2023")
    end

    context "with different user" do
      let(:user) { create(:user, username: "jane_smith", created_at: Date.new(2022, 12, 1)) }

      it "displays the correct username and date" do
        expect(subject).to have_content("jane_smith")
        expect(subject).to have_content("J")
        expect(subject).to have_content("December 01, 2022")
      end
    end
  end
end
