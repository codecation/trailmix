class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :auto_orient
  process resize_to_fit: [800, 800], quality: 80

  ALLOWED_CONTENT_TYPES = %r{\Aimage/(jpeg|png|gif|webp|heic|heif)\z}

  def extension_allowlist
    %w(jpg jpeg gif png webp heic heif)
  end

  # Checked against the file's actual bytes, so a renamed SVG/MVG/PS file
  # never reaches ImageMagick.
  def content_type_allowlist
    ALLOWED_CONTENT_TYPES
  end

  def filename
    "#{hash}.jpg"
  end

  private

  def hash
    Digest::SHA1.hexdigest file_contents
  end

  def file_contents
    read
  end
end
