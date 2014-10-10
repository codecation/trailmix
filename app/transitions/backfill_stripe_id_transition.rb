class BackfillStripeIdTransition
  def self.perform
    new.perform
  end

  def perform
    stripe_customers.each do |stripe_customer|
      update_stripe_id_for(stripe_customer)
    end
  end

  private

  def update_stripe_id_for(stripe_customer)
    user = User.find_by(email: stripe_customer.email)

    if user && user.stripe_id.blank?
      user.update_attributes!(stripe_id: stripe_customer.id)
    end
  end

  def stripe_customers
    Stripe::Customer.all(limit: 100)
  end
end
