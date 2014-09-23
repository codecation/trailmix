class PromptMailer < ActionMailer::Base
  def prompt(user, entry)
    @entry = entry

    mail to: user.email, from: "today@trailmix.life"
  end
end
