require "rails_helper"

feature "Admin views dashboard" do
  scenario "and sees data about the site" do
    admin = create(:user, email: "ben@trailmix.life")

    login_as(admin)
    visit admin_dashboard_path

    expect(page).to have_content("Sign ups")
  end
end
