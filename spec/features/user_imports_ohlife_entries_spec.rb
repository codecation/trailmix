require "rails_helper"

feature "User imports their OhLife entries" do
  scenario "immediately after creating their account" do
    user = create(:user)

    login_as(user)
    visit dashboard_path
    click_link "import your OhLife entries"
    file_path = Rails.root + "spec/fixtures/ohlife_export.txt"
    attach_file('import_raw_file', file_path)
    click_button "Upload"

    expect(page).to have_content("Import complete!")
    expect(Import.count).to eq(1)
    expect(user.entries.count).to eq(2)
  end
end
