Rails.configuration.stripe = {
  publishable_key: ENV.fetch("STRIPE_PUBLISHABLE_KEY"),
  secret_key: ENV.fetch("STRIPE_SECRET_KEY"),
  plan_name: ENV.fetch("STRIPE_PLAN_NAME")
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
Stripe.api_version = ENV.fetch("STRIPE_API_VERSION", "2025-12-15.clover")
Stripe.max_network_retries = 2
