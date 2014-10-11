feature "User cancels account" do
  scenario "and their information is removed" do
    subscription = create(:subscription)
    user = subscription.user
    entry = create(:entry, user: user)

    login_as(user)
    visit edit_settings_path
    click_link "Close my account"
    fill_in :reason, with: "I decided I hate journaling."
    click_button "Close my account"

    expect(page).to have_content("account has been removed")
    expect(page).to have_content("subscription has been canceled")
  end
end
