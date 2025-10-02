require "rails_helper"

RSpec.feature "Admin edits content", type: :feature do
  let(:admin)         { create(:user, :admin) }
  let(:regular_user)  { create(:user) }
  let(:topic)         { create(:topic, title: "Original Topic Title", user: regular_user) }
  let!(:post)         { create(:post, content: "Original post content", topic: topic, user: regular_user) }

  scenario "admin can edit a topic" do
    login_as(admin)
    visit forum_topic_path(topic)

    click_link "edit", href: edit_forum_topic_path(topic)

    fill_in "Title*",   with: "Updated Topic Title"
    fill_in "Content*", with: "Updated topic content"
    click_button "Update"

    expect(page).to have_content("Topic was successfully updated")
    expect(page).to have_content("Updated Topic Title")
    expect(page).to have_content("Updated topic content")
  end

  scenario "admin can edit a post" do
    login_as(admin)
    visit forum_topic_path(topic)

    click_link "edit", href: edit_forum_topic_post_path(topic, post)

    fill_in "forum_post_content", with: "Updated post content"
    click_button "Update"

    expect(page).to have_content("Updated post content")
  end

  scenario "regular user cannot see edit links for topics" do
    login_as(regular_user, scope: :user)
    other_topic = create(:topic, user: create(:user))

    visit forum_topic_path(other_topic)
    expect(page).not_to have_link("edit")
  end
end
