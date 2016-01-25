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
end
