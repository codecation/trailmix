class AddPromptDeliveryHourToUsers < ActiveRecord::Migration
  def change
    add_column :users,
               :prompt_delivery_hour,
               :integer,
               default: 2, # 2AM UTC
               null: false
  end
end
