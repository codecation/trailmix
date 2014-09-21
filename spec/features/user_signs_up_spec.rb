require "rails_helper"

feature "User signs up" do
  scenario "using valid credentials" do
    visit sign_up_path
    fill_in "email", with: "test@example.com"
    fill_in "password", with: "password"
    click_button "Sign Up"

    expect(current_path).to eq dashboard_path
  end
end
