class User < ActiveRecord::Base
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :registerable,
         :trackable,
         :validatable

  has_many :entries, dependent: :destroy
  has_many :imports, dependent: :destroy
  has_one :subscription, dependent: :destroy

  before_create :generate_reply_token

  delegate :stripe_customer_id, to: :subscription

  def self.promptable(time = Time.zone.now.utc)
    where(prompt_delivery_hour: time.hour)
  end

  def reply_email
    "#{reply_token}@#{ENV.fetch('SMTP_DOMAIN')}"
  end

  def generate_reply_token
    self.reply_token = ReplyToken.generate(email)
  end

  def newest_entry
    entries.newest
  end

  def prompt_entry
    PromptEntry.best(entries)
  end

  def prompt_delivery_hour
    PromptDeliveryHour.new(super, time_zone).in_time_zone
  end

  def prompt_delivery_hour=(hour)
    super PromptDeliveryHour.new(hour, time_zone).in_utc
  end
end
