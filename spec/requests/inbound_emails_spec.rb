require "spec_helper"

describe "Inbound email webhook", type: :request do
  around do |example|
    original = ENV.to_h.slice("INBOUND_EMAIL_USERNAME", "INBOUND_EMAIL_PASSWORD")
    ENV["INBOUND_EMAIL_USERNAME"] = "sendgrid"
    ENV["INBOUND_EMAIL_PASSWORD"] = "s3cret"
    example.run
  ensure
    ENV.delete("INBOUND_EMAIL_USERNAME")
    ENV.delete("INBOUND_EMAIL_PASSWORD")
    ENV.update(original)
  end

  it "rejects posts without credentials" do
    expect_any_instance_of(EmailProcessor).not_to receive(:process)

    post "/email_processor", params: { to: "someone@example.com" }

    expect(response).to have_http_status(:unauthorized)
  end

  it "rejects posts with the wrong credentials" do
    post "/email_processor",
      params: { to: "someone@example.com" },
      headers: auth_header("sendgrid", "wrong")

    expect(response).to have_http_status(:unauthorized)
  end

  it "accepts posts with the configured credentials" do
    user = create(:user)

    post "/email_processor",
      params: {
        to: user.reply_email,
        from: "someone@example.com",
        subject: "Hello",
        text: "Today was great"
      },
      headers: auth_header("sendgrid", "s3cret")

    expect(response).to have_http_status(:ok)
    expect(user.newest_entry.body).to eq("Today was great")
  end

  def auth_header(name, password)
    {
      "HTTP_AUTHORIZATION" =>
        ActionController::HttpAuthentication::Basic.encode_credentials(name, password)
    }
  end
end
