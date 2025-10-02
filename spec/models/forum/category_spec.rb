# == Schema Information
#
# Table name: forum_categories
#
#  id           :integer          not null, primary key
#  bg_color     :string           not null
#  name         :string           not null
#  slug         :string           not null
#  topics_count :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_forum_categories_on_slug  (slug) UNIQUE
#
require "rails_helper"

RSpec.describe Forum::Category, type: :model do
  context "validations" do
    it "is valid with valid attributes" do
      category = build(:category)
      expect(category).to be_valid
    end

    it "is invalid without a name" do
      category = build(:category, name: nil)
      expect(category).not_to be_valid
      expect(category.errors[:name]).to include("can't be blank")
    end

    it "is invalid with a duplicate name" do
      create(:category, name: "General")
      duplicate = build(:category, name: "General")
      expect(duplicate).not_to be_valid
      expect(duplicate.errors[:name]).to include("has already been taken")
    end

    it "is invalid without a bg_color" do
      category = build(:category, bg_color: nil)
      expect(category).not_to be_valid
      expect(category.errors[:bg_color]).to include("can't be blank")
    end

    it "is invalid with a bad hex color" do
      category = build(:category, bg_color: "red")
      expect(category).not_to be_valid
      expect(category.errors[:bg_color]).to include("must be a valid hex color code (e.g. #FFF or #FFFFFF)")
    end

    it "is valid with a short hex color" do
      category = build(:category, bg_color: "#ABC")
      expect(category).to be_valid
    end

    it "is valid with a full hex color" do
      category = build(:category, bg_color: "#A1B2C3")
      expect(category).to be_valid
    end
  end
end
