class AddStripeCustomerIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :stripe_customer_id, :string, null: false
  end
end
