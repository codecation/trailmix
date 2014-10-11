RSpec.describe User, :type => :model do
  it { should have_many(:entries).dependent(:destroy) }
  it { should have_many(:imports).dependent(:destroy) }
  it { should have_one(:subscription).dependent(:destroy) }

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
    it "starts with the reply token" do
      user = create(:user)

      expect(user.reply_email).to start_with(user.reply_token)
    end

    it "ends with the email domain" do
      user = create(:user)
      email_domain = ENV.fetch("SMTP_DOMAIN")

      expect(user.reply_email).to end_with("@#{email_domain}")
    end
  end

  describe "#newest_entry" do
    it "returns the newest entry by date" do
      user = create(:user)
      newest_entry = create(:entry, user: user, date: 1.day.ago)
      oldest_entry = create(:entry, user: user, date: 2.days.ago)

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
      Timecop.freeze(Time.utc(2014, 10, 1)) do
        user = create(:user, time_zone: "Melbourne") # Melbourne is UTC+10
        user.update_column :prompt_delivery_hour, 5

        prompt_delivery_hour = user.prompt_delivery_hour

        expect(prompt_delivery_hour).to eq(15)
      end
    end
  end

  describe "#prompt_delivery_hour=" do
    it "writes the prompt delivery hour in utc" do
      Timecop.freeze(Time.utc(2014, 10, 1)) do
        user = create(:user, time_zone: "Melbourne") # Melbourne is UTC+10

        user.prompt_delivery_hour = 5
        prompt_delivery_hour = user.read_attribute(:prompt_delivery_hour)

        expect(prompt_delivery_hour).to eq(19)
      end
    end
  end

  describe "#stripe_customer_id" do
    it "delegates to the subscription" do
      subscription = create(:subscription)
      user = subscription.user

      expect(user.stripe_customer_id).to eq(subscription.stripe_customer_id)
    end
  end
end
