feature "User visits dashboard" do
  scenario "when signed in" do
    sign_in_user

    visit dashboard_path

    expect(current_path).to eq dashboard_path
  end

  scenario "when signed out" do
    visit dashboard_path

    expect(current_path).to eq new_registration_path
  end

  def sign_in_user
    user = create(:user)
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Sign in"
  end
end
