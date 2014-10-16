require "rails_helper"

feature "User imports their OhLife entries" do
  scenario "immediately after creating their account", sidekiq: :inline do
    user = create(:user)

    login_as(user)
    visit entries_path
    click_link "import your OhLife entries"
    file_path = Rails.root + "spec/fixtures/ohlife_export.txt"
    attach_file('import_ohlife_export', file_path)
    click_button "Start Import"

    expect(page).to have_content("We're importing your entries")
    expect(Import.count).to eq(1)
    expect(user.entries.count).to eq(2)
  end

  scenario "when signed out" do
    visit new_import_path

    expect(current_path).to eq(new_user_session_path)
  end
end
