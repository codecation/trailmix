require "sidekiq"
require "sidekiq/web"

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [
    ENV.fetch("SIDEKIQ_WEB_USER"),
    ENV.fetch("SIDEKIQ_WEB_PASSWORD")
  ]
end

# https://devcenter.heroku.com/articles/connecting-heroku-redis#connecting-in-ruby
Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV["REDIS_URL"],
    ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
      url: ENV["REDIS_URL"],
      ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE }
  }
  config.logger = Rails.logger if Rails.env.test?
end
