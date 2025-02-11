feature "User updates their credit card" do
  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  scenario "successfully" do
    stripe_customer = Stripe::Customer.create
    user = create(:user)
    create(:subscription, user: user, stripe_customer_id: stripe_customer.id)

    login_as(user)
    update_credit_card

    expect(page).to have_content("Credit card updated successfully")
  end

  def update_credit_card
    visit edit_settings_path
    click_link "Update credit card"
    fill_in "number", with: "4242424242424242"
    fill_in "exp_month", with: "04"
    fill_in "exp_year", with: "2016"
    fill_in "cvc", with: "216"
    click_button "Update credit card"
  end
end
