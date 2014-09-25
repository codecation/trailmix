source "https://rubygems.org"

ruby "2.1.2"

gem "airbrake"
gem "autoprefixer-rails"
gem "bootstrap-sass", "~> 3.2.0"
gem "bourbon", "~> 3.2.1"
gem "coffee-rails"
gem "devise"
gem "email_validator"
gem "flutie"
gem "griddler"
gem "griddler-sendgrid"
gem "high_voltage"
gem "i18n-tasks"
gem "jquery-rails"
gem "kaminari"
gem "neat", "~> 1.5.1"
gem "normalize-rails", "~> 3.0.0"
gem "pg"
gem "rack-ssl-enforcer"
gem "rack-timeout"
gem "rails", "4.1.4"
gem "recipient_interceptor"
gem "redis"
gem "sass-rails", "~> 4.0.3"
gem "sidekiq"
gem "simple_form"
gem "sinatra", ">= 1.3.0", require: false
gem "stripe", :git => "https://github.com/stripe/stripe-ruby"
gem "title"
gem "uglifier"
gem "unicorn"

group :development do
  gem "spring"
  gem "spring-commands-rspec"
end

group :development, :test do
  gem "awesome_print"
  gem "byebug"
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.0.0"
end

group :test do
  gem "database_cleaner"
  gem "fake_stripe"
  gem "formulaic"
  gem "launchy"
  gem "selenium-webdriver"
  gem "shoulda-matchers", require: false
  gem "timecop"
  gem "webmock"
end

group :staging, :production do
  gem 'rails_12factor'
  gem "newrelic_rpm", ">= 3.7.3"
end
