source "https://rubygems.org"

ruby "2.5.7"

gem "airbrake"
gem "autoprefixer-rails"
gem "binding_of_caller"
gem "bourbon", "~> 3.2.1"
gem "carrierwave"
gem "chartkick"
gem "coffee-rails"
gem "devise", "~> 4.7.1"
gem "email_reply_parser"
gem "email_validator"
gem "flutie"
gem "fog"
gem "griddler"
gem "griddler-sendgrid"
gem "groupdate"
gem "high_voltage"
gem "i18n-tasks"
gem "jquery-rails"
gem "kaminari"
gem "mini_magick"
gem "neat", "~> 1.5.1"
gem "normalize-rails", "~> 3.0.0"
gem "pg"
gem "rack-ssl-enforcer"
gem "rack-timeout"
gem "rails", "~> 4.2.0"
gem "recipient_interceptor"
gem "redis"
gem "sass-rails", "~> 4.0.3"
gem "sidekiq"
gem "simple_form", "~> 3.1.0"
gem "sinatra", ">= 1.3.0", require: false
gem "stripe", "~> 1.57.1"
gem "title"
gem "uglifier"
gem "unicorn"
gem "xmlrpc"

group :development do
  gem "better_errors"
  gem "spring"
  gem "spring-commands-rspec"
end

group :development, :test do
  gem "awesome_print"
  gem "byebug"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "pry-rails"
  gem "rspec-activemodel-mocks"
  gem "rspec-rails", "~> 3.7.0"
  gem "web-console", "~> 2.0"
end

group :test do
  gem "capybara-webkit"
  gem "database_cleaner"
  gem "fake_stripe"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers", require: false
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem "rails_12factor", "~> 0.0.3"
  gem "rails_serve_static_assets", "~> 0.0.4"
end

group :production do
  gem "skylight"
end
