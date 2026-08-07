class Rack::Attack
  throttle("logins by IP", limit: 10, period: 1.minute) do |request|
    request.ip if request.post? && request.path == "/users/sign_in"
  end

  throttle("logins by email", limit: 5, period: 1.minute) do |request|
    if request.post? && request.path == "/users/sign_in"
      request.params.dig("user", "email").to_s.strip.downcase.presence
    end
  end
end
