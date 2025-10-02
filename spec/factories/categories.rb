FactoryBot.define do
  factory :category, class: 'Forum::Category' do
    sequence(:name) { |n| "Category #{n}" }
    bg_color { "#FF5733" }
  end
end
