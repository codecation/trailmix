class BackfillSubscriptionsTransition
  def self.perform
    new.perform
  end

  def perform
    stripe_customers.each do |stripe_customer|
      create_subscription_for(stripe_customer)
    end
  end

  private

  def create_subscription_for(stripe_customer)
    user = User.find_by(email: stripe_customer.email)

    if user && user.subscription.blank?
      user.create_subscription!(stripe_customer_id: stripe_customer.id)
    end
  end

  def stripe_customers
    Stripe::Customer.all(limit: 100)
  end
end
