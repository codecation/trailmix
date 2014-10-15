feature "User exports their entries" do
  scenario "from the FAQ" do
    user = create(:user)
    entries = [
      create(:entry, user: user, body: "first entry"),
      create(:entry, user: user, body: "second entry"),
      create(:entry, user: user, body: "third entry")
    ]

    login_as(user)
    visit entries_path
    click_link "FAQ"
    click_link "export"

    expect(page.body).to include(*entries.map(&:body))
  end
end
