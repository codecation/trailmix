class CreateCancellation < ActiveRecord::Migration
  def change
    create_table :cancellations do |t|
      t.string :email, null: false
      t.string :stripe_customer_id, null: false
      t.text :reason

      t.timestamps null: false
    end
  end
end
