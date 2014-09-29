feature "User changes timezone" do
  scenario "from Pacific Time to Melbourne" do
    user = create(:user, time_zone: "Pacific Time (US & Canada)")
    create(:entry, user: user, created_at: "2014-01-01 00:00:00")
    login_as(user)

    visit dashboard_path
    expect(page).to have_content("Tuesday")

    click_link "Settings"
    select "Melbourne", from: :user_time_zone
    click_button "Save"

    expect(page).to have_content("settings have been saved")
    expect(current_path).to eq dashboard_path
    expect(page).to have_content("Wednesday")

    click_link "Settings"

    expect(page).to have_select(
      :user_time_zone,
      selected: "(GMT+10:00) Melbourne"
    )
  end
end
