describe PromptDeliveryHour do
  after { Timecop.return }

  context "when not in daylight savings" do
    before { Timecop.freeze Time.utc(2014, 10, 1) }

    describe "#in_time_zone" do
      it "returns the hour in the specified time zone" do
        hour = 15
        time_zone = "Eastern Time (US & Canada)" # UTC-4

        delivery_hour = PromptDeliveryHour.new(hour, time_zone).in_time_zone

        expect(delivery_hour).to eq(11)
      end

      it "always returns an hour in the 24 hour range" do
        hour = 1
        time_zone = "Eastern Time (US & Canada)" # UTC-4

        delivery_hour = PromptDeliveryHour.new(hour, time_zone).in_time_zone

        expect(delivery_hour).to eq(21)
      end
    end

    describe "#in_utc" do
      it "returns the hour in the utc time zone" do
        hour = 15
        time_zone = "Eastern Time (US & Canada)" # UTC-4

        delivery_hour = PromptDeliveryHour.new(hour, time_zone).in_utc

        expect(delivery_hour).to eq(19)
      end

      it "always returns an hour in the 24 hour range" do
        hour = 20
        time_zone = "Eastern Time (US & Canada)" # UTC-4

        delivery_hour = PromptDeliveryHour.new(hour, time_zone).in_utc

        expect(delivery_hour).to eq(0)
      end
    end
  end

  context "when in daylight savings" do
    before { Timecop.freeze Time.utc(2014, 1, 1) }

    describe "#in_time_zone" do
      it "returns the hour in the specified time zone accounting for DST" do
        hour = 15
        time_zone = "Eastern Time (US & Canada)" # UTC-5

        delivery_hour = PromptDeliveryHour.new(hour, time_zone).in_time_zone

        expect(delivery_hour).to eq(10)
      end
    end

    describe "#in_utc" do
      it "returns the hour in the utc time zone accounting for DST" do
        hour = 15
        time_zone = "Eastern Time (US & Canada)" # UTC-5

        delivery_hour = PromptDeliveryHour.new(hour, time_zone).in_utc

        expect(delivery_hour).to eq(20)
      end
    end
  end
end
