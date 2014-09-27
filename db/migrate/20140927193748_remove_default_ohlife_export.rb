class RemoveDefaultOhlifeExport < ActiveRecord::Migration
  def up
    change_column_default :imports, :ohlife_export, nil
  end

  def down
    change_column_default :imports, :ohlife_export, ""
  end
end
