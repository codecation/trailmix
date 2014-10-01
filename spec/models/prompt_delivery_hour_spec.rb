describe PromptDeliveryHour do
  describe "#in_time_zone" do
    it "returns the hour in the specified time zone" do
      hour = 15
      time_zone = "Eastern Time (US & Canada)" # UTC-5

      delivery_hour = PromptDeliveryHour.new(hour, time_zone).in_time_zone

      expect(delivery_hour).to eq(10)
    end

    it "always returns an hour in the 24 hour range" do
      hour = 5
      time_zone = "Samoa" # UTC-11

      delivery_hour = PromptDeliveryHour.new(hour, time_zone).in_time_zone

      expect(delivery_hour).to eq(18)
    end
  end

  describe "#in_utc" do
    it "returns the hour in the utc time zone" do
      hour = 15
      time_zone = "Eastern Time (US & Canada)" # UTC-5

      delivery_hour = PromptDeliveryHour.new(hour, time_zone).in_utc

      expect(delivery_hour).to eq(20)
    end

    it "always returns an hour in the 24 hour range" do
      hour = 20
      time_zone = "Samoa" # UTC-11

      delivery_hour = PromptDeliveryHour.new(hour, time_zone).in_utc

      expect(delivery_hour).to eq(7)
    end
  end
end
