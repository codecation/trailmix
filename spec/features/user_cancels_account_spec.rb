feature "User cancels account" do
  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  scenario "and their information is removed" do
    stripe_customer = Stripe::Customer.create
    subscription = create(:subscription, stripe_customer_id: stripe_customer.id)
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
