class CheckoutSessionsController < ApplicationController
  before_action :authenticate_user!, only: [:portal]

  def create
    user = find_or_build_user

    unless user.valid?
      flash[:error] = user.errors.full_messages.to_sentence
      return redirect_to new_registration_path
    end

    session = Stripe::Checkout::Session.create(
      mode: "subscription",
      customer_email: user.email,
      client_reference_id: user.id || user.email,
      metadata: { email: user.email },
      line_items: [{
        price: ENV.fetch("STRIPE_PRICE_ID"),
        quantity: 1
      }],
      success_url: checkout_success_url(session_id: "{CHECKOUT_SESSION_ID}"),
      cancel_url: new_registration_url
    )

    session_store[:pending_user_params] = user_params.to_h if user.new_record?
    redirect_to session.url, allow_other_host: true
  end

  def success
    session_id = params[:session_id]

    if StripeEvent.processed?(session_id)
      flash[:error] = "This checkout session has already been used. Please sign in."
      return redirect_to new_user_session_path
    end

    checkout_session = Stripe::Checkout::Session.retrieve(session_id)

    if checkout_session.payment_status == "paid" || checkout_session.status == "complete"
      email = checkout_session.customer_email ||
              checkout_session.customer_details&.email
      existing_user = User.find_by(email: email)

      if existing_user
        # Completing a checkout only proves control of a card, not of this
        # account — activate the subscription but require a normal sign-in.
        activate_subscription(existing_user, checkout_session)
        StripeEvent.record!(event_id: session_id, event_type: "checkout.session.success")
        flash[:notice] = "Your subscription is now active. Please sign in."
        redirect_to new_user_session_path
      elsif (user = create_user_from_pending_params)
        activate_subscription(user, checkout_session)
        StripeEvent.record!(event_id: session_id, event_type: "checkout.session.success")
        sign_in(user)
        flash[:notice] = "Welcome to Trailmix! Your subscription is now active."
        redirect_to entries_path
      else
        flash[:error] = "Something went wrong. Please contact support."
        redirect_to new_registration_path
      end
    else
      flash[:error] = "Payment was not completed. Please try again."
      redirect_to new_registration_path
    end
  end

  def portal
    unless current_user.subscription&.stripe_customer_id
      flash[:error] = "No subscription found."
      return redirect_to edit_settings_path
    end

    portal_session = Stripe::BillingPortal::Session.create(
      customer: current_user.stripe_customer_id,
      return_url: edit_settings_url
    )

    redirect_to portal_session.url, allow_other_host: true
  end

  private

  def find_or_build_user
    User.find_by(email: params[:email]) || User.new(user_params)
  end

  def create_user_from_pending_params
    pending_params = session_store.delete(:pending_user_params)
    return nil unless pending_params

    user = User.create!(pending_params)
    WelcomeMailerWorker.perform_async(user.id)
    user
  end

  def activate_subscription(user, checkout_session)
    stripe_sub = Stripe::Subscription.retrieve(checkout_session.subscription)
    subscription = user.subscription || user.build_subscription
    subscription.update!(
      stripe_customer_id: checkout_session.customer,
      stripe_subscription_id: checkout_session.subscription,
      status: stripe_sub.status,
      current_period_end: Time.at(stripe_sub.current_period_end),
      cancel_at_period_end: stripe_sub.cancel_at_period_end
    )
  end

  def user_params
    params.permit(:email, :password)
  end

  def session_store
    session
  end
end
