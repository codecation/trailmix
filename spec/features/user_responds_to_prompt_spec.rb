feature "User responds to a prompt" do
  include Rack::Test::Methods

  scenario "and an entry is created" do
    user = create(:user, entries: [])

    simulate_email_from(user)

    expect(user.reload.entries).not_to be_empty
  end

  scenario "and it was sent to today@trailmix.life" do
    user = create(:user, entries: [])

    simulate_email_from(user, to: "today@trailmix.life")

    expect(user.reload.entries).not_to be_empty
  end

  def simulate_email_from(user, options = {})
    post("/email_processor", email_params(user).merge(options))
  end

  def email_params(user)
    {
      headers: "Received: by 127.0.0.1 with SMTP...",
      to: user.reply_email,
      cc: "CC <cc@example.com>",
      from: user.email,
      subject: "hello there",
      text: "this is an email message",
      html: "<p>this is an email message</p>",
      SPF: "pass"
    }
  end

  def app
    Rails.application
  end
end
