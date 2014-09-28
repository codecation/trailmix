class AddTimeZoneToUser < ActiveRecord::Migration
  def change
    add_column :users, :time_zone, :string, null: false, default: "UTC"
  end
end
