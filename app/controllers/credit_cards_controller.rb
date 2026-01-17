class CreditCardsController < ApplicationController
  before_action :authenticate_user!

  layout "skinny"

  def edit
  end

  def update
    Stripe::Customer.update(
      current_user.stripe_customer_id,
      card: params[:stripeToken]
    )

    flash.notice = "Credit card updated successfully"
    redirect_to action: :edit
  end
end
