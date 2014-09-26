class Import < ActiveRecord::Base
  has_many :entries
  belongs_to :user

  mount_uploader :ohlife_export, OhlifeExportUploader
end
