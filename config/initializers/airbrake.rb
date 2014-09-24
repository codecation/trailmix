Airbrake.configure do |config|
  config.api_key = ENV.fetch("AIRBRAKE_API_KEY")
end
