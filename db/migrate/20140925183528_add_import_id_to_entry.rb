class AddImportIdToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :import_id, :integer
  end
end
