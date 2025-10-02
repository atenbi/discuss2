require "rails_helper"

RSpec.describe Forum::CategoryService do
  describe ".create_category!" do
    it "creates a new category" do
      name = "Test Category"
      bg_color = "#FF5733"

      expect {
        described_class.create_category!(name: name, bg_color: bg_color)
      }.to change(Forum::Category, :count).by(1)

      category = Forum::Category.last
      expect(category.name).to eq(name)
      expect(category.bg_color).to eq(bg_color)
    end
  end

  describe ".update_category!" do
    let(:category) { FactoryBot.create(:category, name: "Old Name", bg_color: "#FF5733") }

    it "updates the category name" do
      new_name = "New Name"

      described_class.update_category!(category_id: category.id, name: new_name)

      category.reload
      expect(category.name).to eq(new_name)
    end

    it "raises error when category not found" do
      expect {
        described_class.update_category!(category_id: -1, name: "New Name")
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe ".delete_category!" do
    let!(:category) { FactoryBot.create(:category, name: "Test Category", bg_color: "#FF5733") }

    it "deletes the category" do
      expect {
        described_class.delete_category!(category_id: category.id)
      }.to change(Forum::Category, :count).by(-1)
    end

    it "raises error when category not found" do
      expect {
        described_class.delete_category!(category_id: -1)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
