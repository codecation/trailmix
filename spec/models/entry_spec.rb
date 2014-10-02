require 'rails_helper'

RSpec.describe Entry, :type => :model do
  it { should belong_to(:import) }

  describe ".newest" do
    it "sorts entries with the newest first" do
      user = create(:user)

      entries = [
        create(:entry, user: user, created_at: 1.days.ago, date: Time.zone.now),
        create(:entry, user: user, created_at: Time.zone.now),
        create(:entry, user: user, created_at: 1.days.ago),
        create(:entry, user: user, created_at: 2.day.ago)
      ]

      newest_entries = user.entries.newest

      expect(newest_entries).to eq(entries),
        "expected #{entries.map(&:id)}, got #{newest_entries.map(&:id)}"
    end
  end

  describe "#created_today?" do
    context "when the entry was created today in the user's time zone" do
      it "returns true" do
        Timecop.freeze(Time.utc(2014, 1, 1, 8)) do
          user = create(:user, time_zone: "UTC")
          entry = create(:entry, user: user, created_at: 1.hour.ago)

          expect(entry).to be_created_today

          user.update_attribute(:time_zone, "Pacific Time (US & Canada)")

          expect(entry).to_not be_created_today
        end
      end
    end
  end

  describe "#date" do
    it "returns the created date when not set" do
      yesterday = 1.day.ago
      entry = create(:entry, created_at: yesterday, date: nil)

      expect(entry.date).to eq(yesterday)
    end
  end
end
