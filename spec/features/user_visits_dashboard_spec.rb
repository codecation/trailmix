feature "User visits dashboard" do
  scenario "when signed in with entries" do
    user = create(:user)
    create(:entry, user: user, body: "My first entry")
    create(:entry, user: user, body: "My latest entry")

    login_as(user)
    visit dashboard_path

    expect(page).to have_content("My latest entry")
    expect(page).to_not have_content("My first entry")

    click_link 'Older'

    expect(page).to have_content("My first entry")
    expect(page).to_not have_content("My latest entry")
  end

  scenario "when signed in without entries" do
    user = create(:user)

    login_as(user)
    visit dashboard_path

    expect(current_path).to eq dashboard_path
    expect(page).to have_content("Welcome to Trailmix!")
  end

  scenario "when signed out" do
    visit dashboard_path

    expect(current_path).to eq new_registration_path
  end
end
