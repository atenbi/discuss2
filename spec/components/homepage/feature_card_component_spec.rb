require "rails_helper"
require "ostruct"

RSpec.describe Homepage::FeatureCardComponent, type: :component do
  let(:feature) do
    OpenStruct.new(
      title: "Amazing Feature",
      description: "This is a detailed description of the amazing feature.",
      img_url: "test-image.jpg"
    )
  end

  describe "rendering" do
    subject { render_inline(described_class.new(feature: feature)) }

    before do
      allow_any_instance_of(ActionView::Helpers::AssetUrlHelper).to receive(:asset_path).and_return("/assets/test-image.jpg")
    end

    it "renders the component" do
      expect(subject).to have_css("div[role='img']")
    end

    it "displays the feature title" do
      expect(subject).to have_content(feature.title)
    end

    it "displays the feature description" do
      expect(subject).to have_content(feature.description)
    end

    it "renders title as heading" do
      expect(subject).to have_css("h3", text: feature.title)
    end

    it "renders description in span" do
      expect(subject).to have_css("span", text: feature.description)
    end

    it "includes background image" do
      expect(subject).to have_css("div[style*='background-image']")
    end
  end
end
