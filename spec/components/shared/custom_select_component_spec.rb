require "rails_helper"

RSpec.describe Shared::CustomSelectComponent, type: :component do
  let(:form_name) { "category_id" }
  let(:default_item) { Shared::CustomSelectComponent::Item.new("", "Please select") }
  let(:items) do
    [
      Shared::CustomSelectComponent::Item.new("1", "Technology", "#3B82F6"),
      Shared::CustomSelectComponent::Item.new("2", "Design", "#10B981")
    ]
  end
  let(:component) do
    described_class.new(
      form_name: form_name,
      default_item: default_item,
      items: items
    )
  end

  describe "rendering" do
    subject { render_inline(component) }

    it "renders the custom select component" do
      expect(subject).to have_css('[data-controller="custom-select"]')
      expect(subject).to have_css('input[type="hidden"][name="category_id"]', visible: false)
      expect(subject).to have_css('[data-custom-select-target="trigger"]')
      expect(subject).to have_css('[data-custom-select-target="list"]')
    end

    it "displays the default item label when no selection" do
      expect(subject).to have_content("Please select")
    end

    it "renders all items in the dropdown" do
      expect(subject).to have_content("Technology")
      expect(subject).to have_content("Design")
    end

    it "has proper ARIA attributes" do
      expect(subject).to have_css('[role="combobox"]')
      expect(subject).to have_css('[role="listbox"]')
      expect(subject).to have_css('[role="option"]', count: 2)
    end

    context "with label" do
      let(:component) do
        described_class.new(
          label: "Select Category",
          form_name: form_name,
          default_item: default_item,
          items: items
        )
      end

      it "renders the label" do
        expect(subject).to have_css('label', text: "Select Category")
      end
    end

    context "with aria_label" do
      let(:component) do
        described_class.new(
          aria_label: "Choose a category",
          form_name: form_name,
          default_item: default_item,
          items: items
        )
      end

      it "sets the aria-label attribute" do
        expect(subject).to have_css('[aria-label="Choose a category"]')
      end
    end

    context "with selected item" do
      let(:component) do
        described_class.new(
          form_name: form_name,
          default_item: default_item,
          items: items,
          selected_slug_or_id: "1"
        )
      end

      it "displays the selected item label" do
        expect(subject).to have_content("Technology")
      end

      it "sets the hidden input value" do
        expect(subject).to have_css('input[value="1"]', visible: false)
      end

      it "marks the selected item as selected" do
        expect(subject).to have_css('[aria-selected="true"]', text: "Technology")
        expect(subject).to have_css('[aria-selected="false"]', text: "Design")
      end
    end

    context "with custom CSS width" do
      let(:component) do
        described_class.new(
          form_name: form_name,
          default_item: default_item,
          items: items,
          css_width: "w-64"
        )
      end

      it "applies the custom width class" do
        expect(subject).to have_css('.w-64')
      end
    end

    context "with remove filter option" do
      let(:component) do
        described_class.new(
          form_name: form_name,
          default_item: default_item,
          items: items,
          selected_slug_or_id: "1",
          show_remove_filter: true
        )
      end

      it "shows the remove filter option" do
        expect(subject).to have_content("remove filter")
        expect(subject).to have_css('[data-id=""]', text: "remove filter")
      end
    end

    context "without remove filter when no selection" do
      let(:component) do
        described_class.new(
          form_name: form_name,
          default_item: default_item,
          items: items,
          show_remove_filter: true
        )
      end

      it "does not show the remove filter option" do
        expect(subject).not_to have_content("remove filter")
      end
    end

    context "with auto submit" do
      let(:component) do
        described_class.new(
          form_name: form_name,
          default_item: default_item,
          items: items,
          auto_submit: true
        )
      end

      it "uses chooseAndSubmit action" do
        expect(subject).to have_css('[data-action*="chooseAndSubmit"]')
      end
    end

    context "without auto submit" do
      it "uses choose action" do
        expect(subject).to have_css('[data-action*="choose"]')
      end
    end
  end

  describe "#selected_label" do
    context "when no item is selected" do
      it "returns the default item label" do
        expect(component.selected_label).to eq("Please select")
      end
    end

    context "when an item is selected" do
      let(:component) do
        described_class.new(
          form_name: form_name,
          default_item: default_item,
          items: items,
          selected_slug_or_id: "1"
        )
      end

      it "returns the selected item label" do
        expect(component.selected_label).to eq("Technology")
      end
    end

    context "when selected_slug_or_id doesn't match any item" do
      let(:component) do
        described_class.new(
          form_name: form_name,
          default_item: default_item,
          items: items,
          selected_slug_or_id: "999"
        )
      end

      it "returns the default item label" do
        expect(component.selected_label).to eq("Please select")
      end
    end
  end

  describe "#choose_action" do
    context "when auto_submit is true" do
      let(:component) do
        described_class.new(
          form_name: form_name,
          default_item: default_item,
          items: items,
          auto_submit: true
        )
      end

      it "returns 'chooseAndSubmit'" do
        expect(component.choose_action).to eq("chooseAndSubmit")
      end
    end

    context "when auto_submit is false" do
      it "returns 'choose'" do
        expect(component.choose_action).to eq("choose")
      end
    end
  end

  describe ".category_items" do
    let!(:category1) { create(:category, name: "Tech", slug: "tech", bg_color: "#3B82F6") }
    let!(:category2) { create(:category, name: "Design", slug: "design", bg_color: "#10B981") }

    it "returns default item and category items" do
      result = described_class.category_items

      expect(result[:default_item].label).to eq("Please select")
      expect(result[:items].size).to eq(2)
      expect(result[:items].first.label).to eq("Tech")
      expect(result[:items].first.slug_or_id).to eq("tech")
    end

    it "accepts custom default label" do
      result = described_class.category_items(default_label: "Choose category")

      expect(result[:default_item].label).to eq("Choose category")
    end

    it "can use id instead of slug" do
      result = described_class.category_items(slug_or_id: :id)

      expect(result[:items].first.slug_or_id).to eq(category1.id)
    end
  end
end
