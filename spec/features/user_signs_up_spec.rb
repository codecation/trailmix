feature "User signs up" do
  scenario "using valid credentials" do
    visit new_user_registration_path
    fill_in "user_email", with: "test@example.com"
    fill_in "user_password", with: "abc"
    click_button "Sign up"

    expect(current_path).to eq dashboard_path
    expect(ActionMailer::Base.deliveries).not_to be_empty
  end
end
