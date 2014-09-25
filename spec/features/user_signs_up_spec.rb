feature "User signs up", js: true do
  Capybara.default_wait_time = 6

  VALID_CARD_NUMBER = "4242424242424242"

  scenario "using valid data" do
    fill_in_signup_form
    fill_in_stripe_checkout(card_number: VALID_CARD_NUMBER)

    expect_to_be_on_dashboard
    expect(User.count).to eq(1)
    expect(FakeStripe.customer_count).to eq(1)
    expect(ActionMailer::Base.deliveries).not_to be_empty
  end

  scenario "using a duplicate email address" do
    existing_user = create(:user, email: "user@example.com")

    fill_in_signup_form("user@example.com")
    fill_in_stripe_checkout(card_number: VALID_CARD_NUMBER)

    expect(page).to have_content("Email has already been taken")
    expect(FakeStripe.customer_count).to eq(0)
    expect(ActionMailer::Base.deliveries).to be_empty
  end

  scenario "with a credit card that fails to charge" do
    stub_stripe_charge_failure

    fill_in_signup_form
    fill_in_stripe_checkout(card_number: VALID_CARD_NUMBER)

    expect(page).to have_content("Failed to charge card")
    expect(User.count).to eq(0)
    expect(FakeStripe.customer_count).to eq(0)
    expect(ActionMailer::Base.deliveries).to be_empty
  end

  scenario "without providing email or password", js: true do
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

  def stub_stripe_charge_failure
    error = Stripe::CardError.new(double, double, double)
    allow(error).to(receive(:message).and_return("Failed to charge card"))

    allow(Stripe::Customer).to(receive(:create).and_raise(error))
  end

  def expect_to_be_on_dashboard
    expect(page).to have_content("You're on the dashboard!")
  end

  def fill_in_signup_form(email="very-long-email-lol@example.com")
    visit new_registration_path
    fill_in "email", with: email
    fill_in "password", with: "password"
    click_button "Sign up"
  end

  def fill_in_stripe_checkout(values={})
    within_frame("stripe_checkout_app") do
      sleep 0.1
      page.execute_script(%Q{ $('#card_number').val('#{values[:card_number]}'); })
      sleep 0.1
      page.execute_script(%Q{ $('#cc-exp').val('01/20'); })
      sleep 0.1
      fill_in "cc-csc", with: "123"
      sleep 0.1
      click_button "submitButton"
    end
  end

  [true, false].each do |disabled|
    define_method "expect_button_to_be_#{disabled ? 'dis' : 'en'}abled" do
      find_button("Sign up", disabled: disabled)
    end
  end
end
