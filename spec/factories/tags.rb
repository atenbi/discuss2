FactoryBot.define do
  factory :tag, class: "Forum::Tag" do
    sequence(:name) { |n| "Tag #{n}" }
  end
end
