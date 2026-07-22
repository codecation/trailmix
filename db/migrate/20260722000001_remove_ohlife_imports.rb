class RemoveOhlifeImports < ActiveRecord::Migration[8.0]
  def change
    remove_column :entries, :import_id, :integer

    drop_table :imports do |t|
      t.integer :user_id, null: false
      t.datetime :created_at, precision: nil, null: false
      t.datetime :updated_at, precision: nil, null: false
      t.string :ohlife_export, null: false
    end
  end
end
