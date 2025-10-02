require "rails_helper"

RSpec.feature "User creates a topic", type: :feature, js: true do
  let(:user)      { create(:user, :forum_user) }
  let!(:category) { create(:category, name: "General") }
  let!(:tag)      { create(:tag, name: "Announcement") }

  scenario "signed-in user creates a new topic" do
    login_as(user, scope: :user)
    visit new_forum_topic_path

    find('[data-controller="custom-select"] [data-action="click->custom-select#toggle"]').click
    find("[data-custom-select-target='item'][data-id='#{category.id}']").click

    execute_script("document.querySelector('select[name=\"forum_topic[tag_ids][]\"]').value = '#{tag.id}'")
    execute_script("document.querySelector('select[name=\"forum_topic[tag_ids][]\"]').dispatchEvent(new Event('change', { bubbles: true }))")

    fill_in "Title*",   with: "My First Topic"
    fill_in "Content*", with: "This is the content of my first topic."
    click_button "Create"

    expect(page)
      .to have_content("Topic was successfully created")
      .and have_content("My First Topic")
  end

  scenario "unauthenticated user is redirected to sign in page" do
    visit new_forum_topic_path

    expect(current_path).to eq(new_user_session_path)

    expect(page).to have_content(/log in/i)
  end
end
