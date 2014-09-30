class PromptDeliveryHour
  attr_reader :hour, :time_zone_offset

  def initialize(hour, time_zone_offset)
    @hour = hour.to_i
    @time_zone_offset = time_zone_offset.to_i
  end

  def in_time_zone
    in_24_hours(hour + time_zone_offset)
  end

  def in_utc
    in_24_hours(hour - time_zone_offset)
  end

  private

  def in_24_hours(hour)
    if hour < 0
      hour + 24
    elsif hour > 23
      hour - 24
    else
      hour
    end
  end
end
