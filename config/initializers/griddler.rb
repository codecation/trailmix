Griddler.configure do |config|
  config.processor_class = EmailProcessor
  config.reply_delimiter = '-- REPLY ABOVE THIS LINE --'
  config.email_service = :sendgrid
end
