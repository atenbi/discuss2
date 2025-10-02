require "rails_helper"

RSpec.feature "User visits forum topics index page", type: :feature do
  let!(:topic1)   { create(:topic, title: "First Topic") }
  let!(:topic2)   { create(:topic, title: "Second Topic") }
  let!(:category) { create(:category, name: "General", slug: "general") }

  scenario "user sees navbar, sidebar, category dropdown, search field, and topics" do
    visit forum_topics_path

    expect(page).to have_css("nav")
    expect(page).to have_css("aside")

    expect(page).to have_css('[data-controller="custom-select"]')
    expect(page).to have_selector("input[type='search']#q_title_cont")

    expect(page).to have_content("First Topic")
    expect(page).to have_content("Second Topic")
  end

  scenario "user can filter topics by category", js: true do
    visit forum_topics_path

    find('[data-controller="custom-select"] [data-action="click->custom-select#toggle"]').click
    find("[data-custom-select-target='item'][data-id='general']").click

    expect(page).to have_current_path(forum_topics_path(category: "general"))
  end

  scenario "user can search for topics", js: true do
    visit forum_topics_path

    fill_in "q[title_cont]", with: "First"
    find("input#q_title_cont").send_keys(:enter)

    expect(page).to have_content("First Topic")
    expect(page).not_to have_content("Second Topic")
  end
end
