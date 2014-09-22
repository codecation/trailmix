class WelcomeMailer < ActionMailer::Base
  def welcome(user)
    mail(
      from: "today@trailmix.life",
      to: user.email,
      subject: "Write your first entry"
    )
  end
end
