source "https://rubygems.org"

ruby file: ".ruby-version"

gem "airbrake"
gem "benchmark"
gem "bigdecimal", "~> 3.1.9"
gem "binding_of_caller"
gem "carrierwave"
gem "chartkick"
gem "devise", "~> 4.9.4"
gem "drb"
gem "email_reply_parser"
gem "fog-aws"
gem "griddler"
gem "griddler-sendgrid"
gem "groupdate"
gem "jquery-rails"
gem "kaminari"
gem "mini_magick"
gem "mutex_m"
gem "ostruct"
gem "pg", "~> 1.0"
gem "puma"
gem "rack-timeout"
gem "rails", "~> 8.0.0"
gem "recipient_interceptor"
gem "redis"
gem "sass-rails", "~> 6.0.0"
gem "sidekiq", "< 8"
gem "sinatra", "~> 4.2.0", require: false
gem "sprockets", ">= 2.12.5"
gem "stripe", "~> 1.57.1"
gem "xmlrpc"

group :development do
  gem "better_errors"
  gem "spring"
  gem "spring-commands-rspec"
  gem "web-console"
end

group :development, :test do
  gem "awesome_print"
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "pry-rails"
  gem "rspec-activemodel-mocks"
  gem "rspec-rails", "~> 6.1.0"
end

group :test do
  gem "selenium-webdriver"
  gem "database_cleaner"
  gem "formulaic"
  gem "stripe-ruby-mock", "~> 2.4.0"
  gem "launchy"
  gem "timecop"
  gem "webmock"
  gem "rails-controller-testing"
end

group :staging, :production do
  gem "rails_12factor", "~> 0.0.3"
  gem "rails_serve_static_assets", "~> 0.0.4"
end
