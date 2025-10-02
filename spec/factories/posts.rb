FactoryBot.define do
  factory :post, class: "Forum::Post" do
    content { "Sample post content" }
    association :user
    association :topic
  end
end
