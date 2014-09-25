class SubscriptionsController < ApplicationController
  def create
    user = build_user

    if user.valid?
      create_stripe_customer
      user.save!
      send_welcome_email(user)
      sign_in(user)
      redirect_to dashboard_path
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

  def create_stripe_customer
    Stripe::Customer.create(
      email: params[:email],
      card: params[:stripe_card_id],
      plan: Rails.configuration.stripe[:plan_name]
    )
  end

  def send_welcome_email(user)
    WelcomeMailer.welcome(user).deliver
  end
end
