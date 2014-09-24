class RemoveStripeCustomerIdFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :stripe_customer_id
  end
end
