class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :entries, dependent: :destroy
  has_many :imports, dependent: :destroy
  has_one :subscription, dependent: :destroy

  before_create :generate_reply_token

  delegate :stripe_customer_id, to: :subscription

  def self.promptable(time = Time.zone.now)
    where(id: promptable_user_ids(time))
  end

  def self.promptable_user_ids(time)
    select(:id, :time_zone, :prompt_delivery_hour).select do |user|
      local_hour = time.in_time_zone(user.time_zone).hour
      user.read_attribute(:prompt_delivery_hour) == local_hour
    end.map(&:id)
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
    read_attribute(:prompt_delivery_hour)
  end

  def prompt_delivery_hour=(hour)
    write_attribute(:prompt_delivery_hour, hour.to_i)
  end
end
