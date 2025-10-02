require "rails_helper"

RSpec.describe Shared::AvatarComponent, type: :component do
  let(:username) { "JohnDoe" }
  let(:bg_color) { "#3B82F6" }
  let(:component) { described_class.new(username: username, bg_color: bg_color) }

  describe "rendering" do
    subject { render_inline(component) }

    context "when username and bg_color are present" do
      it "renders content" do
        expect(subject).to have_css('[style*="border-radius: 50%"]')
        expect(subject).to have_content("J")
      end
    end

    context "when username is blank" do
      let(:username) { "" }
      it "does not render content" do
        expect(subject).not_to have_css('[style*="border-radius: 50%"]')
        expect(subject).not_to have_content("J")
      end
    end

    context "when bg_color is blank" do
      let(:bg_color) { "" }

      it "does not render content" do
        expect(subject).not_to have_css('[style*="border-radius: 50%"]')
        expect(subject).not_to have_content("J")
      end
    end
  end
end
