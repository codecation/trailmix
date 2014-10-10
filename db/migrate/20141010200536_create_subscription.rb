class CreateSubscription < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id, null: false
      t.string :stripe_customer_id, null: false

      t.timestamps null: false
    end

    add_index :subscriptions, :user_id, unique: true
    add_index :subscriptions, :stripe_customer_id, unique: true
  end
end
