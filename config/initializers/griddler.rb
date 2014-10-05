Griddler.configure do |config|
  config.processor_class = EmailProcessor
  config.reply_delimiter = PromptMailer::PROMPT_TEXT
  config.email_service = :sendgrid
end
