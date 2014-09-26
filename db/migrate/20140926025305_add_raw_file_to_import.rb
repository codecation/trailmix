class AddRawFileToImport < ActiveRecord::Migration
  def change
    add_column :imports, :ohlife_export, :string, default: "", null: false
  end
end
