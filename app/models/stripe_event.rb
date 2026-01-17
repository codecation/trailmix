class StripeEvent < ApplicationRecord
  validates :event_id, presence: true, uniqueness: true
  validates :event_type, presence: true
  validates :processed_at, presence: true

  def self.processed?(event_id)
    exists?(event_id: event_id)
  end

  def self.record!(event_id:, event_type:)
    create!(event_id: event_id, event_type: event_type, processed_at: Time.current)
  rescue ActiveRecord::RecordNotUnique
    # Already processed, ignore
    false
  end
end
