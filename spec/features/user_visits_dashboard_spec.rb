feature "User visits dashboard" do
  scenario "when signed in" do
    user = create(:user)

    login_as(user)
    visit dashboard_path

    expect(current_path).to eq dashboard_path
  end

  scenario "when signed out" do
    visit dashboard_path

    expect(current_path).to eq new_registration_path
  end
end
