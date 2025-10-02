require "rails_helper"

RSpec.describe Pages::FeatureCardComponent, type: :component do
  let(:title) { "Amazing Feature" }
  let(:description) { "This is a detailed description of the amazing feature." }

  subject { render_inline(described_class.new(title: title, description: description)) }

  it "renders the component" do
    expect(subject).to have_css("div[role='article']")
  end

  it "displays the title" do
    expect(subject).to have_content(title)
  end

  it "displays the description" do
    expect(subject).to have_content(description)
  end
end
