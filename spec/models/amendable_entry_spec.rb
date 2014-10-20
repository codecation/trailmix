describe AmendableEntry do
  describe ".create!" do
    context "when an entry with the same date does not exist" do
      it "creates a new entry" do
        today = Date.current
        user = create(:user)

        AmendableEntry.create!(user: user, date: today, body: "I am fine")
        entry_body = user.newest_entry.body

        expect(entry_body).to eq("I am fine")
      end
    end

    context "when an entry with the same date already exists" do
      it "amends the existing entry" do
        today = Date.current
        user = create(:user)
        entry = create(:entry, user: user, date: today, body: "I am fine")

        AmendableEntry.create!(user: user, date: today, body: "I am sad")
        entry_body = entry.reload.body

        expect(entry_body).to eq("I am fine\n\nI am sad")
      end
    end
  end
end
