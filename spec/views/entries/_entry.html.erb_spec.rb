require "rails_helper"

describe "entries/_entry" do
  it "highlights the searched-for term" do
    user = build_stubbed(:user)
    allow(view).to receive(:current_user).and_return(user)
    entry = build_stubbed(:entry, body: "I want to get a cat")
    search = double("search", term: "cat")
    assign(:search, search)

    render "entries/entry", entry: entry

    expect(rendered).to have_css("mark", text: search.term)
  end

end
