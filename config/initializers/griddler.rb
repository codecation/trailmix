require_relative "../../app/models/email_processor"
require_relative "../../app/mailers/prompt_mailer"
require_relative "../../app/mailers/welcome_mailer"

Griddler.configure do |config|
  config.processor_class = EmailProcessor
  config.reply_delimiter = [
    PromptMailer::PROMPT_TEXT,
    WelcomeMailer::START_OF_MESSAGE
  ]
  config.email_service = :sendgrid
end
