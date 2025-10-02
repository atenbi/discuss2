require "rails_helper"

RSpec.describe Forum::TagService do
  describe ".create_tag!" do
    it "creates a new tag" do
      name = "Test Tag"

      expect {
        described_class.create_tag!(name: name)
      }.to change(Forum::Tag, :count).by(1)

      tag = Forum::Tag.last
      expect(tag.name).to eq(name)
    end
  end

  describe ".update_tag!" do
    let(:tag) { create(:tag, name: "Old Name") }

    it "updates the tag name" do
      new_name = "New Name"

      described_class.update_tag!(tag_id: tag.id, name: new_name)

      tag.reload
      expect(tag.name).to eq(new_name)
    end

    it "raises error when tag not found" do
      expect {
        described_class.update_tag!(tag_id: -1, name: "New Name")
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe ".delete_tag!" do
    let!(:tag) { create(:tag) }

    it "deletes the tag" do
      expect {
        described_class.delete_tag!(tag_id: tag.id)
      }.to change(Forum::Tag, :count).by(-1)
    end

    it "raises error when tag not found" do
      expect {
        described_class.delete_tag!(tag_id: -1)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
