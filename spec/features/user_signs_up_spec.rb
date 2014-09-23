feature "User signs up" do
  Capybara.default_wait_time = 6

  scenario "using valid data", js: true do
    email = "test@example.com"

    visit landing_path
    fill_in "email", with: email
    fill_in "password", with: "password"
    click_button "Sign up"

    within_frame("stripe_checkout_app") do
      page.execute_script(%Q{ $('#card_number').val('4242424242424242'); })
      page.execute_script(%Q{ $('#cc-exp').val('01/20'); })
      fill_in "cc-csc", with: "123"
      click_button "submitButton"
    end

    expect(page).to have_content("Success!")
    expect(User.find_by_email(email)).to be_present
    expect(FakeStripe.customer_count).to eq(1)
    expect(ActionMailer::Base.deliveries).not_to be_empty
  end
end
