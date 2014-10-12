class PromptEntry
  def initialize(entries, time_zone)
    @entries = entries
    @time_zone = time_zone
  end

  def self.best(entries, time_zone)
    new(entries, time_zone).best
  end

  def best
    interesting || random
  end

  private

  attr_reader :entries, :time_zone

  def interesting
    entries.by_date.where(date: dates).last
  end

  def random
    entries.random
  end

  def dates
    durations.map { |duration| today - duration }
  end

  def durations
    [1.year, 1.month, 1.week]
  end

  def today
    Time.current.in_time_zone(time_zone).to_date
  end
end
