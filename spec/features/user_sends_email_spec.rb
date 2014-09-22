require 'rails_helper'
require 'rack/test'

feature "User sends email" do
  include Rack::Test::Methods

  scenario "and an entry is created" do
    user = create(:user)

    response = post("/email_processor", email_params.merge(from: user.email))

    expect(user.entries).not_to be_empty
  end

  def email_params
    {
      headers: 'Received: by 127.0.0.1 with SMTP...',
      to: 'thoughtbot <tb@example.com>',
      cc: 'CC <cc@example.com>',
      from: 'John Doe <someone@example.com>',
      subject: 'hello there',
      text: 'this is an email message',
      html: '<p>this is an email message</p>',
      SPF: "pass"
    }
  end

  def app
    Rails.application
  end
end
