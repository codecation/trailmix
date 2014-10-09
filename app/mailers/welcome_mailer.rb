class WelcomeMailer < ActionMailer::Base
  START_OF_MESSAGE = "Welcome to Trailmix, a private place to write."

  def welcome(user)
    mail(
      from: "Trailmix <#{user.reply_email}>",
      to: user.email,
      subject: "Write your first entry"
    )
  end
end
