class Entry < ActiveRecord::Base
  belongs_to :import
  belongs_to :user

  def self.by_date
    order("date DESC")
  end

  def self.newest
    by_date.first
  end

  def self.random
    order("RANDOM()").first
  end

  def for_today?
    date == Time.zone.now.in_time_zone(user.time_zone).to_date
  end

  def body=(new_body)
    super([body, new_body].compact.join("\n\n"))
  end
end
