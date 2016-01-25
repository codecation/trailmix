require_relative "production"

config.middleware.delete(Rack::SslEnforcer)

Mail.register_interceptor(
  RecipientInterceptor.new(ENV.fetch("EMAIL_RECIPIENTS"))
)

Rails.application.configure do
  # ...

  config.action_mailer.default_url_options = { host: 'trailmix-staging.herokuapp.com' }
end
