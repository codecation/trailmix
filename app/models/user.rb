class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :entries, dependent: :destroy
  has_many :imports, dependent: :destroy

  def self.promptable(time = Time.zone.now.utc)
    where(prompt_delivery_hour: time.hour)
  end

  def newest_entry
    entries.last
  end

  def random_entry
    entries.sample
  end

  def prompt_delivery_hour
    PromptDeliveryHour.new(super, time_zone_offset).in_time_zone
  end

  def prompt_delivery_hour=(hour)
    super PromptDeliveryHour.new(hour, time_zone_offset).in_utc
  end

  def time_zone_offset
    ActiveSupport::TimeZone[time_zone].utc_offset / 1.hour
  end
end
