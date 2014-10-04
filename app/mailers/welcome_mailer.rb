class WelcomeMailer < ActionMailer::Base
  def welcome(user)
    mail(
      from: "Trailmix <#{user.reply_email}>",
      to: user.email,
      subject: "Write your first entry"
    )
  end
end
