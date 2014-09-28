RSpec.describe User, :type => :model do
  it { should have_many(:entries).dependent(:destroy) }
  it { should have_many(:imports).dependent(:destroy) }

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

  describe "#in_time_zone" do
    it "returns the provided time in the user's time zone" do
      time = Time.utc(2014, 1, 1)
      user = create(:user)

      user.time_zone = "Pacific Time (US & Canada)"

      expect(user.in_time_zone(time).day).to eq 31

      user.time_zone = "Melbourne"

      expect(user.in_time_zone(time).day).to eq 1
    end
  end
end
