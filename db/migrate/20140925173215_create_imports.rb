class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.integer :user_id, null: false
      t.attachment :raw_file, null: false

      t.timestamps null: false
    end
  end
end
