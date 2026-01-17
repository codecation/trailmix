feature "User views entries" do
  scenario "when signed in with entries" do
    user = create(:user)
    create(:entry, user: user, body: "My first entry", date: 2.days.ago)
    create(:entry, user: user, body: "My latest entry", date: 1.day.ago)

    login_as(user)
    visit entries_path

    expect(page).to have_content("My latest entry")
    expect(page).to have_content("My first entry")
  end

  scenario "when paginating entries" do
    user = create(:user)
    26.times { |i| create(:entry, user: user, body: "Entry #{i}", date: i.days.ago) }

    login_as(user)
    visit entries_path

    expect(page).to have_content("Entry 0")
    expect(page).to have_content("Entry 24")
    expect(page).to_not have_content("Entry 25")

    click_link "Older"

    expect(page).to have_content("Entry 25")
    expect(page).to_not have_content("Entry 0")
  end

  scenario "when an entry includes a photo" do
    user = create(:user)
    entry = create(:entry, :with_photo, user: user)

    login_as(user)
    visit entries_path

    expect(page).to have_css("img[src='#{entry.photo.url}']")
  end

  scenario "when signed in without entries" do
    user = create(:user)

    login_as(user)
    visit entries_path

    expect(current_path).to eq entries_path
    expect(page).to have_content("Welcome to Trailmix")
  end

  scenario "when signed out" do
    visit entries_path

    expect(current_path).to eq new_user_session_path
  end
end
