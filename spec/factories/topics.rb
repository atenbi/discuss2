FactoryBot.define do
  factory :topic, class: "Forum::Topic" do
    sequence(:title) { |n| "Topic #{n}" }
    content { "Sample content" }
    association :user
    association :category
  end
end
