class Entry < ApplicationRecord
  belongs_to :import, optional: true
  belongs_to :user

  mount_uploader :photo, PhotoUploader

  def self.by_date
    order("date DESC")
  end

  def self.newest
    by_date.first
  end

  def self.random
    order(Arel.sql("RANDOM()")).first
  end

  def for_today?
    date == Time.zone.now.in_time_zone(user.time_zone).to_date
  end
end
