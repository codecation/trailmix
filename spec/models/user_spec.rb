RSpec.describe User, :type => :model do
  describe "#newest_entry" do
    it "returns the newest entry" do
      user = create(:user)
      first_entry = create(:entry, user: user, created_at: 1.day.ago)
      newest_entry = create(:entry, user: user, created_at: Time.zone.now)

      expect(user.newest_entry).to eq(newest_entry)
    end
  end

  describe "#random_entry" do
    it "returns a random entry" do
      user = create(:user)
      entry = create(:entry, user: user)

      expect(user.random_entry).to eq(entry)
    end
  end
end
