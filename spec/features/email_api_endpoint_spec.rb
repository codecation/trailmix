require 'rails_helper'
require 'rack/test'

feature "The email api endpoint" do
  include Rack::Test::Methods

  scenario "can successfully receive a response" do
    response = post("/email_processor", email_params)

    expect(response).to be_successful
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
