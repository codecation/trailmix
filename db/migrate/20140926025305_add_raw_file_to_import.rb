class AddRawFileToImport < ActiveRecord::Migration
  def change
    add_column :imports, :ohlife_export, :string, null: false
  end
end
