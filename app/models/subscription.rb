class Subscription < ApplicationRecord
  belongs_to :user

  ACTIVE_STATUSES = %w[active trialing].freeze

  def paid?
    ACTIVE_STATUSES.include?(status)
  end

  def stripe_customer
    @stripe_customer ||= Stripe::Customer.retrieve(stripe_customer_id)
  end

  def stripe_subscription
    return nil unless stripe_subscription_id
    @stripe_subscription ||= Stripe::Subscription.retrieve(stripe_subscription_id)
  end

  def sync_from_stripe!
    return unless stripe_subscription_id

    sub = stripe_subscription
    update!(
      status: sub.status,
      current_period_end: Time.at(sub.current_period_end),
      cancel_at_period_end: sub.cancel_at_period_end,
      canceled_at: sub.canceled_at ? Time.at(sub.canceled_at) : nil,
      ended_at: sub.ended_at ? Time.at(sub.ended_at) : nil
    )
  end
end
