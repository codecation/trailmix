source "https://rubygems.org"

ruby file: ".ruby-version"

gem "airbrake"
gem "autoprefixer-rails"
gem "benchmark"
gem "bigdecimal", "~> 3.1.9"
gem "binding_of_caller"
gem "carrierwave"
gem "chartkick"
# https://stackoverflow.com/a/79361034
gem 'concurrent-ruby', '1.3.4'
gem "devise", "~> 4.9.4"
gem "drb"
gem "email_reply_parser"
gem "email_validator"
gem "flutie"
gem "fog"
gem "griddler"
gem "griddler-sendgrid"
gem "groupdate"
gem "high_voltage"
gem "jquery-rails"
gem "kaminari"
gem "mini_magick"
gem "mutex_m"
# https://github.com/ruby/net-imap/issues/16#issuecomment-803086765
gem "net-http"
gem "normalize-rails", "~> 3.0.0"
gem "ostruct"
gem "pg", "~> 1.0"
gem "rack-timeout"
gem "rails", "~> 8.0.0"
gem "recipient_interceptor"
gem "redis"
gem "reline"
gem "sass-rails", "~> 6.0.0"
gem "sidekiq", "~> 5.2.10"
gem "sprockets", ">= 2.12.5"
gem "simple_form", "~> 5.0.3"
gem "sinatra", "~> 2.0.8", require: false
gem "stripe", "~> 1.57.1"
gem "title"
gem "unicorn"
gem "xmlrpc"

group :development do
  gem "better_errors"
  gem "spring"
  gem "spring-commands-rspec"
  gem "web-console", "~> 2.0"
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
  gem "puma", "~> 6.4.0"
  gem "rails-controller-testing"
end

group :staging, :production do
  gem "rails_12factor", "~> 0.0.3"
  gem "rails_serve_static_assets", "~> 0.0.4"
end
