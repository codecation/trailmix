require 'rails_helper'

RSpec.describe Entry, :type => :model do
  it { should belong_to(:import) }

  describe ".newest" do
    it "sorts entries, by date, with the newest first" do
      user = create(:user)

      entries = [
        create(:entry, user: user, date: Time.zone.now, created_at: 1.day.ago),
        create(:entry, user: user, date: 1.days.ago, created_at: 3.days.ago),
        create(:entry, user: user, date: 2.days.ago, created_at: Time.zone.now),
        create(:entry, user: user, date: 3.day.ago, created_at: 2.days.ago),
      ]

      newest_entries = user.entries.newest

      expect(newest_entries).to eq(entries),
        "expected #{entries.map(&:id)}, got #{newest_entries.map(&:id)}"
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
