describe "searches/show" do
  context "when no entries are found" do
    it "informs the user" do
      search = mock_model("Search", term: "cat", entries: [])
      assign(:search, search)

      render template: "searches/show"

      expect(rendered).to(include("Sorry, we couldn't find any entries"))
    end
  end

  context "when no search term is provided" do
    it "does not inform the user" do
      search = mock_model("Search", term: "", entries: [])
      assign(:search, search)

      render template: "searches/show"

      expect(rendered).to_not include("we couldn't find any entries")
    end
  end
end
