# Receives SendGrid Inbound Parse posts. Once INBOUND_EMAIL_USERNAME and
# INBOUND_EMAIL_PASSWORD are set, SendGrid's parse URL must include them
# (https://user:pass@host/email_processor) or posts are rejected.
class InboundEmailsController < Griddler::EmailsController
  before_action :authenticate_sender, if: :credentials_configured?

  private

  def authenticate_sender
    http_basic_authenticate_or_request_with(
      name: ENV.fetch("INBOUND_EMAIL_USERNAME"),
      password: ENV.fetch("INBOUND_EMAIL_PASSWORD")
    )
  end

  def credentials_configured?
    ENV["INBOUND_EMAIL_USERNAME"].present? &&
      ENV["INBOUND_EMAIL_PASSWORD"].present?
  end
end
