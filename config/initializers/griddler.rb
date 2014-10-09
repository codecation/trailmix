Griddler.configure do |config|
  config.processor_class = EmailProcessor
  config.reply_delimiter = [
    PromptMailer::PROMPT_TEXT,
    WelcomeMailer::START_OF_MESSAGE
  ]
  config.email_service = :sendgrid
end
