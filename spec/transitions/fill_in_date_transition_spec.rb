describe FillInDateTransition do
  describe "#perform" do
    it "fills in missing entry dates with the created date" do
      today = Time.zone.now.to_date
      entries = [
        create(:entry, created_at: today - 1.day, date: nil),
        create(:entry, created_at: today - 2.days, date: nil),
        create(:entry, created_at: today - 10.days, date: nil)
      ]

      FillInDateTransition.new.perform

      entries.each do |entry|
        date = entry.reload.read_attribute(:date)
        created_at = entry.created_at.to_date

        expect(date).to eq(created_at)
      end
    end

    it "does not mess with entries that already have dates" do
      today = Time.zone.now.to_date
      entry = create(:entry, created_at: today - 1.day, date: today)

      FillInDateTransition.new.perform

      expect(entry.reload.date).to eq(today)
    end
  end
end
