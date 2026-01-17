class CreateStripeEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :stripe_events do |t|
      t.string :event_id, null: false
      t.string :event_type, null: false
      t.datetime :processed_at, null: false

      t.timestamps
    end

    add_index :stripe_events, :event_id, unique: true
  end
end
