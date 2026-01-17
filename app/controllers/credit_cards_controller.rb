class CreditCardsController < ApplicationController
  before_action :authenticate_user!

  layout "skinny"

  def edit
  end

  def update
    payment_method = Stripe::PaymentMethod.attach(
      params[:stripe_payment_method_id],
      customer: current_user.stripe_customer_id
    )

    Stripe::Customer.update(
      current_user.stripe_customer_id,
      invoice_settings: { default_payment_method: payment_method.id }
    )

    flash.notice = "Credit card updated successfully"
    redirect_to action: :edit
  end
end
