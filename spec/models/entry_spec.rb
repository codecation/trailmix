require 'rails_helper'

RSpec.describe Entry, :type => :model do
  describe ".newest" do
    it "sorts entries with the newest first" do
      user = create(:user)

      entries = [
        create(:entry, user: user, created_at: Time.zone.now),
        create(:entry, user: user, created_at: 1.days.ago),
        create(:entry, user: user, created_at: 2.day.ago)
      ]

      newest_entries = user.entries.newest

      expect(newest_entries).to eq(entries),
        "expected #{entries.map(&:id)}, got #{newest_entries.map(&:id)}"
    end
  end
end
