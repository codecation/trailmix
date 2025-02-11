source "https://rubygems.org"

ruby "2.7.4"

gem "airbrake"
gem "autoprefixer-rails"
gem "bigdecimal", "~> 3.1.9"
gem "binding_of_caller"
gem "bourbon", "~> 3.2.1"
gem "carrierwave"
gem "chartkick"
# https://stackoverflow.com/a/79361034
gem 'concurrent-ruby', '1.3.4'
gem "devise", "~> 4.7.3"
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
# https://github.com/ruby/net-imap/issues/16#issuecomment-803086765
gem "net-http"
gem "normalize-rails", "~> 3.0.0"
gem "pg", "~> 1.0"
gem "rack-ssl-enforcer"
gem "rack-timeout"
gem "rails", "~> 6.0.0"
gem "recipient_interceptor"
gem "redis"
gem "sass-rails", "~> 6.0.0"
gem "sidekiq", "~> 5.2.10"
gem "sprockets", ">= 2.12.5"
gem "simple_form", "~> 5.0.3"
gem "sinatra", "~> 2.0.8", require: false
gem "stripe", "~> 1.57.1"
gem "title"
gem "uglifier"
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
  gem "factory_girl_rails"
  gem "pry-rails"
  gem "rspec-activemodel-mocks"
  gem "rspec-rails", "~> 4.1.2"
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

group :production do
  gem "skylight"
end
