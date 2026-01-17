RSpec.describe User, :type => :model do
  describe ".promptable" do
    it "returns users whose local hour matches the current time" do
      Timecop.freeze(Time.utc(2014, 1, 1, 11)) do # 11AM UTC
        create(:user, time_zone: "UTC", prompt_delivery_hour: 10)
        create(:user, time_zone: "UTC", prompt_delivery_hour: 12)
        utc_11am = create(:user, time_zone: "UTC", prompt_delivery_hour: 11)

        expect(User.promptable).to eq [utc_11am]
      end
    end

    it "handles different time zones correctly" do
      Timecop.freeze(Time.utc(2014, 1, 1, 16)) do # 4PM UTC = 11AM Eastern (UTC-5 in winter)
        utc_user = create(:user, time_zone: "UTC", prompt_delivery_hour: 16)
        eastern_user = create(:user, time_zone: "Eastern Time (US & Canada)", prompt_delivery_hour: 11)
        create(:user, time_zone: "Eastern Time (US & Canada)", prompt_delivery_hour: 16)

        expect(User.promptable).to match_array [utc_user, eastern_user]
      end
    end

    it "handles DST transitions correctly" do
      eastern_user = create(:user, time_zone: "Eastern Time (US & Canada)", prompt_delivery_hour: 11)

      # Winter: Eastern is UTC-5, so 11AM Eastern = 4PM UTC
      Timecop.freeze(Time.utc(2014, 1, 1, 16)) do
        expect(User.promptable).to include(eastern_user)
      end

      # Summer: Eastern is UTC-4, so 11AM Eastern = 3PM UTC
      Timecop.freeze(Time.utc(2014, 7, 1, 15)) do
        expect(User.promptable).to include(eastern_user)
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

  describe "#prompt_entry" do
    it "delegates to PromptEntry" do
      user = create(:user)
      allow(PromptEntry).to(
        receive(:best).with(user.entries).
        and_return("best entry"))

      entry = user.prompt_entry

      expect(entry).to eq("best entry")
    end
  end

  describe "#prompt_delivery_hour" do
    it "returns the stored local hour directly" do
      user = create(:user, time_zone: "Melbourne")
      user.update_column :prompt_delivery_hour, 8

      expect(user.prompt_delivery_hour).to eq(8)
    end
  end

  describe "#prompt_delivery_hour=" do
    it "stores the local hour directly without UTC conversion" do
      user = create(:user, time_zone: "Melbourne")

      user.prompt_delivery_hour = 8

      expect(user.read_attribute(:prompt_delivery_hour)).to eq(8)
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
