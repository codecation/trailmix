class SubscriptionsController < ApplicationController
  def create
    user = build_user

    if user.valid?
      create_subscription(user)
      send_welcome_email(user)
      sign_in(user)
      redirect_to entries_path
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to new_registration_path
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_registration_path
  end

  private

  def build_user
    User.new(email: params[:email],
             password: params[:password])
  end

  def create_subscription(user)
    stripe_customer_id = create_stripe_customer.id
    user.save!
    user.create_subscription!(stripe_customer_id: stripe_customer_id)
  end

  def create_stripe_customer
    customer = Stripe::Customer.create(
      email: params[:email],
      payment_method: params[:stripe_payment_method_id],
      invoice_settings: { default_payment_method: params[:stripe_payment_method_id] }
    )

    Stripe::Subscription.create(
      customer: customer.id,
      items: [{ price: ENV.fetch("STRIPE_PRICE_ID") }],
      default_payment_method: params[:stripe_payment_method_id]
    )

    customer
  end

  def send_welcome_email(user)
    WelcomeMailerWorker.perform_async(user.id)
  end
end
