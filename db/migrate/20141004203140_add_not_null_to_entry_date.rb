class AddNotNullToEntryDate < ActiveRecord::Migration
  def up
    change_column :entries, :date, :date, null: false
  end

  def down
    change_column :entries, :date, :date, null: true
  end
end
