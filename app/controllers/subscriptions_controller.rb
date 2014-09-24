class SubscriptionsController < ApplicationController
  def create
    stripe_customer = create_stripe_customer
    user = create_user
    send_welcome_email(user)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to subscriptions_path
  end

  private

  def create_stripe_customer
    Stripe::Customer.create(
      email: params[:email],
      card: params[:stripe_card_id],
      plan: Rails.configuration.stripe[:plan_name]
    )
  end

  def create_user
    User.create!(email: params[:email],
                 password: params[:password])
  end

  def send_welcome_email(user)
    WelcomeMailer.welcome(user).deliver
  end
end
