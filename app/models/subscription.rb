class Subscription < ActiveRecord::Base
  belongs_to :user
  before_destroy :delete_stripe_subscription

  def stripe_customer
    @stripe_customer ||= Stripe::Customer.retrieve(stripe_customer_id)
  end

  private

  def delete_stripe_subscription
    stripe_customer.subscriptions.map(&:delete)
  end
end
