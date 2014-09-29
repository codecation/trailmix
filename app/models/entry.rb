class Entry < ActiveRecord::Base
  belongs_to :import
  belongs_to :user

  scope :newest, -> { order("created_at DESC") }

  def created_today?
    created_at.in_time_zone(user.time_zone).beginning_of_day ==
    Time.zone.now.in_time_zone(user.time_zone).beginning_of_day
  end
end
