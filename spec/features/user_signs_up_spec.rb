feature "User signs up", js: true do
  Capybara.default_wait_time = 6

  VALID_CARD_NUMBER = "4242424242424242"

  scenario "using valid data" do
    fill_in_signup_form
    fill_in_stripe_checkout(card_number: VALID_CARD_NUMBER)

    expect(page).to have_content("Success!")
    expect(User.count).to eq(1)
    expect(FakeStripe.customer_count).to eq(1)
    expect(ActionMailer::Base.deliveries).not_to be_empty
  end

  def fill_in_signup_form
    visit new_registration_path
    fill_in "email", with: "very-long-email-lol@example.com"
    fill_in "password", with: "password"
    click_button "Sign up"
  end

  def fill_in_stripe_checkout(values={})
    within_frame("stripe_checkout_app") do
      page.execute_script(%Q{ $('#card_number').val('#{values[:card_number]}'); })
      sleep 0.1
      page.execute_script(%Q{ $('#cc-exp').val('01/20'); })
      sleep 0.1
      fill_in "cc-csc", with: "123"
      sleep 0.1
      click_button "submitButton"
    end
  end

  scenario "password and email required", js: true do
    visit new_registration_path

    fill_in "email", with: ""
    fill_in "password", with: "password"

    find_button("Sign up", disabled: true)

    fill_in "password", with: ""
    fill_in "email", with: "me@example.com"

    find_button("Sign up", disabled: true)

    fill_in "email", with: "me@example.com"
    fill_in "password", with: "password"

    find_button("Sign up", disabled: false)
  end
end
