feature "User signs up", js: true do
  scenario "without providing email or password" do
    visit new_registration_path

    fill_in "email", with: ""
    fill_in "password", with: "password"

    expect_button_to_be_disabled

    fill_in "password", with: ""
    fill_in "email", with: "me@example.com"

    expect_button_to_be_disabled

    fill_in "email", with: "me@example.com"
    fill_in "password", with: "password"

    expect_button_to_be_enabled
  end

  [true, false].each do |disabled|
    define_method "expect_button_to_be_#{disabled ? 'dis' : 'en'}abled" do
      find_button("Sign up", disabled: disabled)
    end
  end
end
