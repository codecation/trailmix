describe FixFutureDatedEntriesTransition do
  describe "#perform" do
    context "for entries dated in the past" do
      it "does nothing" do
        last_year = 1.year.ago.to_date
        yesterday = 1.day.ago.to_date
        entry_from_last_year = create(:entry, date: last_year)
        entry_from_yesterday = create(:entry, date: yesterday)

        FixFutureDatedEntriesTransition.perform

        entry_from_last_year.reload
        entry_from_yesterday.reload
        expect(entry_from_last_year.date).to eq(last_year)
        expect(entry_from_yesterday.date).to eq(yesterday)
      end
    end

    context "for entries dated in the future" do
      it "fixes the date by moving them one year back" do
        tomorrow = 1.day.from_now.to_date
        next_week = 1.week.from_now.to_date
        entry_from_tomorrow = create(:entry, date: tomorrow)
        entry_from_next_week = create(:entry, date: next_week)

        FixFutureDatedEntriesTransition.perform

        entry_from_tomorrow.reload
        entry_from_next_week.reload
        expect(entry_from_tomorrow.date).to eq(tomorrow - 1.year)
        expect(entry_from_next_week.date).to eq(next_week - 1.year)
      end
    end
  end
end
