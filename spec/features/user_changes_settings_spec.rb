feature "User changes settings" do
  scenario "time zone from Pacific Time to Melbourne" do
    user = create(:user, time_zone: "Pacific Time (US & Canada)")
    create(:entry, user: user, date: Time.utc(2014, 1, 1))
    login_as(user)
    visit entries_path

    click_link "Settings"
    select "Melbourne", from: :user_time_zone
    click_button "Save"

    expect(page).to have_content("settings have been saved")
    expect(current_path).to eq entries_path
  end

  scenario "email delivery time from 9PM to 6AM" do
    user = create(
      :user,
      time_zone: "Melbourne",
      prompt_delivery_hour: 21
    )
    login_as(user)

    visit edit_settings_path
    select "06 AM", from: :user_prompt_delivery_hour
    click_button "Save"

    click_link "Settings"
    expect(page).to have_select(
      :user_prompt_delivery_hour,
      selected: "06 AM"
    )
  end
end
