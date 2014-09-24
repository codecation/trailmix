class AddNotNullToEntryTimestamps < ActiveRecord::Migration
  def up
    change_column :entries, :created_at, :datetime, null: false
    change_column :entries, :updated_at, :datetime, null: false
  end

  def down
    change_column :entries, :created_at, :datetime, null: true
    change_column :entries, :updated_at, :datetime, null: true
  end
end
