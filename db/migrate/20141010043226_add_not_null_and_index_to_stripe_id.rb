class AddNotNullAndIndexToStripeId < ActiveRecord::Migration
  def up
    change_column :users, :stripe_id, :string, null: false
    add_index :users, :stripe_id, unique: true
  end

  def down
    change_column :users, :stripe_id, :string, null: true
    remove_index :users, :stripe_id
  end
end
