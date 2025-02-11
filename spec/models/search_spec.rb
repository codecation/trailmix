describe Search do
  describe "#entries" do
    it "returns entries whose bodies match the search term" do
      user = create(:user)
      matched_entry = create(:entry, user: user, body: "I like cats")
      create(:entry, user: user, body: "I like dogs")
      create(:entry, body: "This guy likes cats too")
      search = Search.new(term: "cats", user: user)

      result = search.entries.map(&:body)

      expect(result).to eq([matched_entry.body])
    end

    it "is not case sensitive" do
      user = create(:user)
      create(:entry, user: user, body: "i like pizza")
      create(:entry, user: user, body: "I REALLY LIKE PIZZA")
      all_user_entries = user.entries.map(&:body)
      search = Search.new(term: "piZZa", user: user)

      result = search.entries.map(&:body)

      expect(result).to contain_exactly(*all_user_entries)
    end

    it "sorts entries by date" do
      user = create(:user)
      create(:entry, user: user, body: "I like cats.", date: 2.days.ago)
      create(:entry, user: user, body: "I still like cats.", date: 1.day.ago)
      entries_sorted_by_date = user.entries.by_date.map(&:body)
      search = Search.new(term: "cats", user: user)

      result = search.entries.map(&:body)

      expect(result).to eq(entries_sorted_by_date)
    end

    it "returns nothing when there's no search term" do
      entry = create(:entry, body: "I like cats")
      search = Search.new(user: entry.user)

      result = search.entries

      expect(result).to be_empty
    end
  end
end
