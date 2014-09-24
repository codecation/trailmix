require "sidekiq"
require "sidekiq/web"

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == [
    ENV.fetch("SIDEKIQ_WEB_USER"),
    ENV.fetch("SIDEKIQ_WEB_PASSWORD")
  ]
end
