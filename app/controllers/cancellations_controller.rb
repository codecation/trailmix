class CancellationsController < ApplicationController
  before_action :authenticate_user!

  def create
    create_cancellation
    cancel_stripe_subscription
    current_user.destroy!
    flash[:notice] = "Your account has been removed and " +
      "your subscription has been canceled."

    redirect_to new_registration_path
  end

  private

  def create_cancellation
    Cancellation.create!(email: current_user.email,
                         stripe_customer_id: current_user.stripe_customer_id,
                         reason: params[:reason])
  end

  def cancel_stripe_subscription
    subscription = current_user.subscription
    return unless subscription&.stripe_subscription_id

    Stripe::Subscription.cancel(subscription.stripe_subscription_id)
  rescue Stripe::InvalidRequestError
    # Subscription may already be canceled in Stripe
  end
end
