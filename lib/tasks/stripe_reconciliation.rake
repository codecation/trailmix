namespace :stripe do
  desc "Reconcile local subscriptions with Stripe's actual subscription data"
  task reconcile: :environment do
    puts "Starting Stripe reconciliation..."
    puts "Found #{Subscription.count} local subscriptions"

    stats = { synced: 0, no_subscription: 0, errors: 0 }

    Subscription.find_each do |subscription|
      reconcile_subscription(subscription, stats)
    end

    puts "\nReconciliation complete!"
    puts "  Synced: #{stats[:synced]}"
    puts "  No active Stripe subscription: #{stats[:no_subscription]}"
    puts "  Errors: #{stats[:errors]}"
  end

  def reconcile_subscription(subscription, stats)
    customer = Stripe::Customer.retrieve(
      subscription.stripe_customer_id,
      expand: ["subscriptions"]
    )

    stripe_sub = customer.subscriptions.data.first

    if stripe_sub.nil?
      puts "  [NO SUB] User ##{subscription.user_id} (#{subscription.user.email}) - no active Stripe subscription"
      subscription.update!(
        status: "canceled",
        ended_at: Time.current
      )
      stats[:no_subscription] += 1
    else
      subscription.update!(
        stripe_subscription_id: stripe_sub.id,
        status: stripe_sub.status,
        current_period_end: Time.at(stripe_sub.current_period_end),
        cancel_at_period_end: stripe_sub.cancel_at_period_end,
        canceled_at: stripe_sub.canceled_at ? Time.at(stripe_sub.canceled_at) : nil,
        ended_at: stripe_sub.ended_at ? Time.at(stripe_sub.ended_at) : nil
      )
      puts "  [SYNCED] User ##{subscription.user_id} (#{subscription.user.email}) - status: #{stripe_sub.status}"
      stats[:synced] += 1
    end
  rescue Stripe::InvalidRequestError => e
    puts "  [ERROR] User ##{subscription.user_id} - Stripe error: #{e.message}"
    subscription.update!(status: "canceled", ended_at: Time.current)
    stats[:errors] += 1
  rescue StandardError => e
    puts "  [ERROR] User ##{subscription.user_id} - #{e.class}: #{e.message}"
    stats[:errors] += 1
  end
end
