RSpec.describe Entry, :type => :model do
  describe ".by_date" do
    it "sorts entries, by date, with the newest first" do
      user = create(:user)

      entries = [
        create(:entry, user: user, date: Date.current, created_at: 1.day.ago),
        create(:entry, user: user, date: 1.days.ago, created_at: 3.days.ago),
        create(:entry, user: user, date: 2.days.ago, created_at: Time.current),
        create(:entry, user: user, date: 3.day.ago, created_at: 2.days.ago),
      ]

      entries_by_date = user.entries.by_date

      expect(entries_by_date).to(
        eq(entries),
        "expected #{entries.map(&:id)}, got #{entries_by_date.map(&:id)}")
    end
  end

  describe ".newest" do
    it "returns the newest dated entry" do
      user = create(:user)
      newest_entry = create(:entry, user: user, date: Date.current)
      create(:entry, user: user, date: 1.day.ago)

      entry = user.entries.newest

      expect(entry).to eq(newest_entry)
    end
  end

  describe ".random" do
    it "returns a random entry" do
      entry = create(:entry)

      expect(Entry.random).to eq(entry)
    end
  end

  describe "#for_today?" do
    context "when the entry is dated for today" do
      it "returns true" do
        Timecop.freeze(Time.utc(2014, 1, 1, 20)) do
          user = create(:user, time_zone: "UTC")
          entry = create(:entry, user: user, date: Time.zone.now)

          expect(entry).to be_for_today

          user.update_attribute(:time_zone, "Guam") # UTC+10

          expect(entry).to_not be_for_today
        end
      end
    end
  end
end
