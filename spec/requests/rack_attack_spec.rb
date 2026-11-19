require "spec_helper"

describe "Rack::Attack throttles", type: :request do
  around do |example|
    original_store = Rack::Attack.cache.store
    Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new
    example.run
  ensure
    Rack::Attack.cache.store = original_store
  end

  it "limits password reset requests per email" do
    4.times do |i|
      post "/users/password",
        params: { user: { email: "victim@example.com" } },
        headers: { "REMOTE_ADDR" => "10.0.0.#{i}" }
    end

    expect(response).to have_http_status(:too_many_requests)
  end

  it "limits daily sign-in attempts per email across IPs" do
    Timecop.freeze(Time.utc(2026, 1, 1, 9))

    31.times do |i|
      post "/users/sign_in",
        params: { user: { email: "victim@example.com", password: "guess#{i}" } },
        headers: { "REMOTE_ADDR" => "10.0.#{i}.1" }
      Timecop.freeze(Time.now + 2.minutes)
    end

    expect(response).to have_http_status(:too_many_requests)
  ensure
    Timecop.return
  end
end
