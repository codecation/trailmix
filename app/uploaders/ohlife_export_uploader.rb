# encoding: utf-8

class OhlifeExportUploader < CarrierWave::Uploader::Base
  def extension_white_list
    %w(txt)
  end
end
