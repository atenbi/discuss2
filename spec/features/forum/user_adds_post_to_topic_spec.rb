require "rails_helper"

RSpec.feature "User adds post to topic", type: :feature do
  let(:user)  { create(:user, :forum_user) }
  let(:topic) { create(:topic, title: "Test Topic") }

  scenario "signed-in user can add a post to a topic" do
    login_as(user, scope: :user)
    visit forum_topic_path(topic)

    fill_in "forum_post_content", with: "This is my reply to the topic"

    click_button "Send Message"
    expect(page).to have_content("This is my reply to the topic")
  end

  scenario "unauthorized user is redirected to sign in when trying to reply" do
    visit forum_topic_path(topic)

    expect(page).to have_link("Reply", href: new_user_session_path)

    click_link "Reply"
    expect(current_path).to eq(new_user_session_path)
  end
end
