class AddStripeFieldsToSubscriptions < ActiveRecord::Migration[8.0]
  def change
    add_column :subscriptions, :stripe_subscription_id, :string
    add_column :subscriptions, :status, :string
    add_column :subscriptions, :current_period_end, :datetime
    add_column :subscriptions, :cancel_at_period_end, :boolean, default: false
    add_column :subscriptions, :canceled_at, :datetime
    add_column :subscriptions, :ended_at, :datetime

    add_index :subscriptions, :stripe_subscription_id, unique: true
    add_index :subscriptions, :status
  end
end
