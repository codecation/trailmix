feature "User signs out" do
  scenario "and we miss them" do
    user = create(:user)
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Sign in"

    click_link "Sign out"

    expect(current_path).to eq new_registration_path
  end
end
