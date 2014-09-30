describe PromptDeliveryHour do
  describe "#in_time_zone" do
    it "returns the hour in the specified time zone" do
      hour = PromptDeliveryHour.new(15, -5).in_time_zone

      expect(hour).to eq(10)
    end

    it "always returns an hour in the 24 hour range" do
      hour = PromptDeliveryHour.new(5, -10).in_time_zone

      expect(hour).to eq(19)
    end
  end

  describe "#in_utc" do
    it "returns the hour in the utc time zone" do
      hour = PromptDeliveryHour.new(15, -5).in_utc

      expect(hour).to eq(20)
    end

    it "always returns an hour in the 24 hour range" do
      hour = PromptDeliveryHour.new(20, -10).in_utc

      expect(hour).to eq(6)
    end
  end
end
