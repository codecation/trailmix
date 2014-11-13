require "rails_helper"

feature "User updates their credit card" do
  scenario "successfully" do
    user = create(:user)
    create(:subscription, user: user)

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
