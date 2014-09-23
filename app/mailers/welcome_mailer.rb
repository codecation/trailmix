class WelcomeMailer < ActionMailer::Base
  def welcome(user)
    mail(
      to: user.email,
      subject: "Write your first entry"
    )
  end
end
