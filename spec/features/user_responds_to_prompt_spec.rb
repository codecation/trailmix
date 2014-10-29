feature "User responds to a prompt" do
  include Rack::Test::Methods

  scenario "and it does not include the original prompt email text" do
    user = create(:user, entries: [])
    text = "User response.\n\n#{PromptMailer::PROMPT_TEXT}\n\nOld entry."

    simulate_email_from(user, text: text)
    result = user.reload.entries.last.body

    expect(result).to eq("User response.")
  end

  def simulate_email_from(user, options = {})
    post("/email_processor", email_params(user).merge(options))
  end

  def email_params(user)
    {
      headers: "Received: by 127.0.0.1 with SMTP...",
      to: user.reply_email,
      cc: "CC <cc@example.com>",
      from: "whocares@example.com",
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
