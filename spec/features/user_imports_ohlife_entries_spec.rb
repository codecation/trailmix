require "rails_helper"

feature "User imports their OhLife entries" do
  scenario "immediately after creating their account" do
    user = create(:user)

    login_as(user)
    visit dashboard_path
    click_link "Import your OhLife entries"

    expect(page).to have_content("OhLife Refugee Import Area")
  end
end
