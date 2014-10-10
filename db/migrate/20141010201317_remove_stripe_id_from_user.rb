class RemoveStripeIdFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :stripe_id
  end

  def down
    add_column :users, :stripe_id, :string
  end
end
