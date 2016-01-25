class AddPhotosToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :photo, :string
  end
end
