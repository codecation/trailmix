CarrierWave.configure do |config|
  config.storage = :fog

  config.fog_credentials = {
    provider:              "AWS",
    aws_access_key_id:     ENV.fetch("AWS_ACCESS_KEY_ID"),
    aws_secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY")
  }

  config.fog_directory = "trailmix"
  config.fog_public    = false
end
