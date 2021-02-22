SMTP_SETTINGS = {
  address: ENV.fetch("SMTP_ADDRESS"), # example: "smtp.sendgrid.net"
  authentication: :plain,
  domain: ENV.fetch("SMTP_DOMAIN"), # example: "this-app.com"
  enable_starttls_auto: true,
  password: ENV.fetch("SENDGRID_API_KEY"),
  port: "587",
  user_name: "apikey"
}
