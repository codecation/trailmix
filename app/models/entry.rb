class Entry < ActiveRecord::Base
  belongs_to :import
  belongs_to :user

  scope :newest, -> { order("date, created_at DESC") }

  def for_today?
    date.in_time_zone(user.time_zone).beginning_of_day ==
    Time.zone.now.in_time_zone(user.time_zone).beginning_of_day
  end

  def date
    super || created_at
  end
end
