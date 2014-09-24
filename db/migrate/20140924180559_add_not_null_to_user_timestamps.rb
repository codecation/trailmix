class AddNotNullToUserTimestamps < ActiveRecord::Migration
  def up
    change_column :users, :created_at, :datetime, null: false
    change_column :users, :updated_at, :datetime, null: false
  end

  def down
    change_column :users, :created_at, :datetime, null: true
    change_column :users, :updated_at, :datetime, null: true
  end
end
