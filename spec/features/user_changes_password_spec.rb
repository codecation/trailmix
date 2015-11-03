feature "User changes password" do
  scenario "when the passwords match" do
    user = create(:user)
    login_as(user)
    visit edit_settings_path
    click_link "Change password"

    fill_in :user_password, with: "BananaM0nkey123"
    fill_in :user_password_confirmation, with: "BananaM0nkey123"
    fill_in :user_current_password, with: "abc123"
    click_button "Update"

    expect(page).to have_content("Your account has been updated successfully.")
    expect(current_path).to eq(root_path)
  end

  scenario "when the passwords do not match" do
    user = create(:user)
    login_as(user)
    visit edit_settings_path
    click_link "Change password"

    fill_in :user_password, with: "asdgs"
    fill_in :user_password_confirmation, with: "BananaM0nkey123"
    fill_in :user_current_password, with: "sadfdsafs"
    click_button "Update"

    expect(page).to have_content("doesn't match Password")
    expect(current_path).to eq(user_registration_path(:user))
  end

  scenario "without entering their current password" do
    user = create(:user)
    login_as(user)
    visit edit_settings_path
    click_link "Change password"

    fill_in :user_password, with: "BananaM0nkey123"
    fill_in :user_password_confirmation, with: "BananaM0nkey123"
    click_button "Update"

    expect(page).to have_content("can't be blank")
    expect(current_path).to eq(user_registration_path(:user))
  end

  scenario "without entering anything" do
    user = create(:user)
    login_as(user)
    visit edit_settings_path
    click_link "Change password"

    click_button "Update"

    expect(page).to have_content("Please review the problems below:")
    expect(current_path).to eq(user_registration_path(:user))
  end
end
