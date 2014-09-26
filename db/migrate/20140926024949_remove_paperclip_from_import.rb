class RemovePaperclipFromImport < ActiveRecord::Migration
  def change
    remove_column :imports, :raw_file_file_name
    remove_column :imports, :raw_file_content_type
    remove_column :imports, :raw_file_file_size
    remove_column :imports, :raw_file_updated_at
  end
end
