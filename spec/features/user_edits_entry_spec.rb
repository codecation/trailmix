feature "User edits entry" do
  scenario "and the entry body is updated" do
    user = create(:user)
    create(:entry, user: user, body: "Original body")

    login_as(user)
    visit entries_path
    click_link "Edit"
    fill_in :entry_body, with: "New body"
    click_button "Save Entry"

    expect(page).to_not have_content("Original body")
    expect(page).to have_content("New body")
  end

  scenario "and the entry belongs to another user" do
    user = create(:user)
    another_user = create(:user)
    another_users_entry = create(:entry, user: another_user)

    login_as(user)
    visit edit_entry_path(another_users_entry)

    expect(page.status_code).to eq(404)
  end
end
