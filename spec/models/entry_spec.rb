require 'rails_helper'

RSpec.describe Entry, :type => :model do
  describe ".newest" do
    it "sorts entries with the newest first" do
      user = create(:user)

      entries = [
        create(:entry, user: user, created_at: Time.zone.now),
        create(:entry, user: user, created_at: 1.day.ago),
        create(:entry, user: user, created_at: 2.days.ago)
      ]

      expect(user.entries.newest).to eq(entries)
    end
  end
end
