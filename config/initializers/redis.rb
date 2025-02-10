# https://devcenter.heroku.com/articles/connecting-heroku-redis#connecting-in-ruby
$redis = Redis.new(url: ENV["REDIS_URL"], ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })
