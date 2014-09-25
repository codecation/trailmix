class PromptMailer < ActionMailer::Base
  def prompt(user, entry)
    @entry = entry

    mail(
      to: user.email,
      subject: "It's #{I18n.l(Date.today, format: :for_prompt)}. How was your day?"
    )
  end
end
