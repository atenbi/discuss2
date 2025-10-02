require "rails_helper"

RSpec.describe Topics::AvatarsStackComponent, type: :component do
  let(:user1) { create(:user, username: "john_doe", avatar_bg_color: "#3B82F6") }
  let(:user2) { create(:user, username: "jane_smith", avatar_bg_color: "#10B981") }
  let(:user3) { create(:user, username: "bob_wilson", avatar_bg_color: "#F59E0B") }
  let(:users_arr) { [ user1, user2, user3 ] }
  let(:component) { described_class.new(users_arr: users_arr) }

  describe "rendering" do
    subject { render_inline(component) }

    context "when users are present" do
      it "renders the avatars stack container" do
        expect(subject).to have_css("div.flex")
      end

      it "renders all user avatars" do
        expect(subject).to have_css("div.relative", count: 3)
      end

      it "renders avatar components for each user" do
        expect(subject).to have_content("J")
        expect(subject).to have_content("J")
        expect(subject).to have_content("B")
      end

      it "renders links to user profiles" do
        expect(subject).to have_css("a[href='#{user_path(user1)}']", count: 1)
        expect(subject).to have_css("a[href='#{user_path(user2)}']", count: 1)
        expect(subject).to have_css("a[href='#{user_path(user3)}']", count: 1)
      end

      it "has proper styling classes for stacking effect" do
        expect(subject).to have_css('div.relative.cursor-pointer', count: 3)
        expect(subject).to have_css('div[class*="ml-[-10px]"]', count: 3)
      end

      it "has hover effects" do
        expect(subject).to have_css('.hover\\:z-10', count: 3)
        expect(subject).to have_css('.hover\\:scale-110', count: 3)
      end

      it "disables turbo for user links" do
        expect(subject).to have_css('a[data-turbo="false"]', count: 3)
      end

      it "renders avatars with correct dimensions" do
        rendered_html = subject.to_html
        expect(rendered_html).to include('width: 28px')
        expect(rendered_html).to include('height: 28px')
        expect(rendered_html).to include('font-size: 12px')
      end
    end

    context "when users array is empty" do
      let(:users_arr) { [] }

      it "does not render anything" do
        expect(subject.to_html.strip).to be_empty
      end
    end

    context "when users array is nil" do
      let(:users_arr) { nil }

      it "does not render anything" do
        expect(subject.to_html.strip).to be_empty
      end
    end

    context "with single user" do
      let(:users_arr) { [ user1 ] }

      it "renders single avatar" do
        expect(subject).to have_css('div.relative', count: 1)
        expect(subject).to have_content("J")
        expect(subject).to have_css("a[href='#{user_path(user1)}']", count: 1)
      end
    end

    context "with many users" do
      let(:users_arr) { create_list(:user, 5) }

      it "renders all avatars" do
        expect(subject).to have_css('div.relative', count: 5)
        expect(subject).to have_css('a', count: 5)
      end
    end
  end

  describe "#render?" do
    context "when users_arr is present" do
      it "returns true" do
        expect(component.send(:render?)).to be true
      end
    end

    context "when users_arr is empty" do
      let(:users_arr) { [] }

      it "returns false" do
        expect(component.send(:render?)).to be false
      end
    end

    context "when users_arr is nil" do
      let(:users_arr) { nil }

      it "returns false" do
        expect(component.send(:render?)).to be false
      end
    end
  end

  describe "integration with Shared::AvatarComponent" do
    subject { render_inline(component) }

    it "passes correct parameters to avatar component" do
      allow(Shared::AvatarComponent).to receive(:new).and_call_original

      render_inline(component)

      users_arr.each do |user|
        expect(Shared::AvatarComponent).to have_received(:new).with(
          username: user.username,
          bg_color: user.avatar_bg_color,
          width: "28px",
          height: "28px",
          font_size: "12px"
        )
      end
    end
  end
end
