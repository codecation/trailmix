class CreditCardsController < ApplicationController
  before_filter :authenticate_user!

  layout "skinny"

  def edit
  end

  def update
    stripe_customer =
      Stripe::Customer.retrieve(current_user.stripe_customer_id)
    stripe_customer.card = params[:stripeToken]
    stripe_customer.save

    flash.notice = "Credit card updated successfully"
    redirect_to action: :edit
  end
end
