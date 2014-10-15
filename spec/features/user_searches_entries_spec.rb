require "rails_helper"

feature "User searches entries" do
  scenario "and sees results" do
    user = create(:user)
    create(:entry, user: user, body: "I like small kittens")
    create(:entry, user: user, body: "I like large dogs")

    login_as(user)
    visit entries_path
    click_link "Search"
    fill_in :search_term, with: "kittens"
    click_button "Search"

    expect(page).to have_content("I like small kittens")
    expect(page).not_to have_content("I like large dogs")
  end
end
