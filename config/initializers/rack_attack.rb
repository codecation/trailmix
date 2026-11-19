class Rack::Attack
  SIGN_IN_PATH = "/users/sign_in".freeze
  PASSWORD_RESET_PATH = "/users/password".freeze

  def self.submitted_email(request)
    request.params.dig("user", "email").to_s.strip.downcase.presence
  end

  throttle("logins by IP", limit: 10, period: 1.minute) do |request|
    request.ip if request.post? && request.path == SIGN_IN_PATH
  end

  throttle("logins by email", limit: 5, period: 1.minute) do |request|
    submitted_email(request) if request.post? && request.path == SIGN_IN_PATH
  end

  # Caps guessing against one account from many IPs.
  throttle("logins by email per day", limit: 30, period: 1.day) do |request|
    submitted_email(request) if request.post? && request.path == SIGN_IN_PATH
  end

  throttle("password resets by IP", limit: 5, period: 1.minute) do |request|
    request.ip if request.post? && request.path == PASSWORD_RESET_PATH
  end

  throttle("password resets by email", limit: 3, period: 1.hour) do |request|
    submitted_email(request) if request.post? && request.path == PASSWORD_RESET_PATH
  end
end
