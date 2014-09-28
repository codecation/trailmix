feature "User changes timezone" do
  scenario "from default to Arizona timezone" do
    user = create(:user)
    login_as(user)

    visit edit_settings_path
    select "(GMT-07:00) Arizona", from: :user_time_zone
    click_button "Save"

    expect(page).to have_content("settings have been saved")
    expect(current_path).to eq dashboard_path

    click_link "Settings"

    expect(page).to have_select(
      :user_time_zone,
      selected: "(GMT-07:00) Arizona"
    )
  end

  scenario "when signed out" do
    visit edit_settings_path

    expect(current_path).to eq(new_user_session_path)
  end
end
