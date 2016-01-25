class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :auto_orient
  process resize_to_fit: [800, 800], quality: 80

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    "#{hash}.jpg" if original_filename.present?
  end

  def fog_public
    true
  end

  private

  def hash
    Digest::SHA1.hexdigest file_contents
  end

  def file_contents
    read
  end
end
