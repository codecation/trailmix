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

  describe "#reply_token" do
    it "is generated automatically before saving" do
      user = build(:user, reply_token: nil)

      user.save

      expect(user.reply_token).to_not be_nil
    end
  end

  describe "#reply_email" do
    it "returns the full reply-to email address" do
      reply_token = "abc123"
      user = create(:user, reply_token: reply_token)
      reply_email = "#{reply_token}@#{ENV.fetch('SMTP_DOMAIN')}"

      expect(user.reply_email).to eq reply_email
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

  describe "#prompt_delivery_hour" do
    it "returns the prompt delivery hour in the user's time zone" do
      user = create(:user, time_zone: "Melbourne") # Melbourne is UTC+10
      user.update_column :prompt_delivery_hour, 5

      prompt_delivery_hour = user.prompt_delivery_hour

      expect(prompt_delivery_hour).to eq(15)
    end
  end

  describe "#prompt_delivery_hour=" do
    it "writes the prompt delivery hour in utc" do
      user = create(:user, time_zone: "Melbourne") # Melbourne is UTC+10

      user.prompt_delivery_hour = 5
      prompt_delivery_hour = user.read_attribute(:prompt_delivery_hour)

      expect(prompt_delivery_hour).to eq(19)
    end
  end
end
