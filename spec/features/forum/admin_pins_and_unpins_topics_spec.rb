require "rails_helper"

RSpec.feature "Admin pins and unpins topics", type: :feature do
  let(:admin) { create(:user, :admin) }
  let(:topic) { create(:topic, title: "Original Topic Title", user: create(:user)) }

  scenario "admin can pin and unpin topics" do
    login_as(admin)
    visit forum_topic_path(topic)

    click_link "Pin topic"
    expect(page).to have_content("Topic pinned successfully")
    expect(page).to have_link("Unpin topic")

    click_link "Unpin topic"
    expect(page).to have_content("Topic unpinned successfully")
    expect(page).to have_link("Pin topic")
  end
end
