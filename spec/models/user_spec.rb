RSpec.describe User, :type => :model do
  it { should have_many(:entries).dependent(:destroy) }
  it { should have_many(:imports).dependent(:destroy) }

  describe ".promptable" do
    it "returns promptable users for the current hour" do
      Timecop.freeze(Time.utc(2014, 1, 1, 11)) do # 11AM UTC
        create(:user, time_zone: "UTC", prompt_delivery_hour: 10)
        create(:user, time_zone: "UTC", prompt_delivery_hour: 12)
        utc_11am = create(:user, time_zone: "UTC", prompt_delivery_hour: 11)

        expect(User.promptable).to eq [utc_11am]
      end
    end
  end

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
