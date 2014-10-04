class PromptDeliveryHour
  def initialize(hour, time_zone)
    @hour = hour.to_i
    @time_zone = time_zone
  end

  def in_time_zone
    in_24_hours(hour + time_zone_offset)
  end

  def in_utc
    in_24_hours(hour - time_zone_offset)
  end

  private

  attr_reader :hour, :time_zone

  def in_24_hours(hour)
    if hour < 0
      hour + 24
    elsif hour > 23
      hour - 24
    else
      hour
    end
  end

  def time_zone_offset
    Time.zone.now.in_time_zone(time_zone).utc_offset / 1.hour
  end
end
