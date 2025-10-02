FactoryBot.define do
  factory :taggable, class: "Forum::Taggable" do
    association :topic, factory: :topic
    association :tag, factory: :tag
  end
end
