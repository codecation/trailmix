class StripeWebhooksController < ApplicationController
  skip_forgery_protection

  def create
    event = verify_webhook_signature
    return head :bad_request unless event

    if StripeEvent.processed?(event.id)
      return head :ok
    end

    handle_event(event)
    StripeEvent.record!(event_id: event.id, event_type: event.type)

    head :ok
  rescue Stripe::SignatureVerificationError
    head :bad_request
  rescue StandardError => e
    Rails.logger.error("Stripe webhook error: #{e.message}")
    head :bad_request
  end

  private

  def verify_webhook_signature
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    endpoint_secret = ENV.fetch("STRIPE_WEBHOOK_SECRET")

    Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
  end

  def handle_event(event)
    case event.type
    when "checkout.session.completed"
      handle_checkout_session_completed(event.data.object)
    when "customer.subscription.created", "customer.subscription.updated"
      handle_subscription_updated(event.data.object)
    when "customer.subscription.deleted"
      handle_subscription_deleted(event.data.object)
    when "invoice.payment_succeeded"
      handle_invoice_payment_succeeded(event.data.object)
    when "invoice.payment_failed"
      handle_invoice_payment_failed(event.data.object)
    end
  end

  def handle_checkout_session_completed(session)
    return unless session.mode == "subscription"

    user_id = session.client_reference_id || session.metadata&.user_id
    return unless user_id

    user = User.find_by(id: user_id)
    return unless user

    stripe_sub = Stripe::Subscription.retrieve(session.subscription)

    subscription = user.subscription || user.build_subscription
    subscription.update!(
      stripe_customer_id: session.customer,
      stripe_subscription_id: session.subscription,
      status: stripe_sub.status,
      current_period_end: Time.at(stripe_sub.current_period_end),
      cancel_at_period_end: stripe_sub.cancel_at_period_end
    )
  end

  def handle_subscription_updated(stripe_sub)
    subscription = find_subscription(stripe_sub)
    return unless subscription

    subscription.update!(
      status: stripe_sub.status,
      current_period_end: Time.at(stripe_sub.current_period_end),
      cancel_at_period_end: stripe_sub.cancel_at_period_end,
      canceled_at: stripe_sub.canceled_at ? Time.at(stripe_sub.canceled_at) : nil,
      ended_at: stripe_sub.ended_at ? Time.at(stripe_sub.ended_at) : nil
    )
  end

  def handle_subscription_deleted(stripe_sub)
    subscription = find_subscription(stripe_sub)
    return unless subscription

    subscription.update!(
      status: stripe_sub.status,
      canceled_at: stripe_sub.canceled_at ? Time.at(stripe_sub.canceled_at) : nil,
      ended_at: stripe_sub.ended_at ? Time.at(stripe_sub.ended_at) : nil
    )
  end

  def handle_invoice_payment_succeeded(invoice)
    return unless invoice.subscription

    subscription = Subscription.find_by(stripe_subscription_id: invoice.subscription)
    return unless subscription

    stripe_sub = Stripe::Subscription.retrieve(invoice.subscription)
    subscription.update!(
      status: stripe_sub.status,
      current_period_end: Time.at(stripe_sub.current_period_end)
    )
  end

  def handle_invoice_payment_failed(invoice)
    return unless invoice.subscription

    subscription = Subscription.find_by(stripe_subscription_id: invoice.subscription)
    return unless subscription

    stripe_sub = Stripe::Subscription.retrieve(invoice.subscription)
    subscription.update!(status: stripe_sub.status)
  end

  def find_subscription(stripe_sub)
    Subscription.find_by(stripe_subscription_id: stripe_sub.id) ||
      Subscription.find_by(stripe_customer_id: stripe_sub.customer)
  end
end
