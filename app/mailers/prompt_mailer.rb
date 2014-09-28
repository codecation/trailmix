class PromptMailer < ActionMailer::Base
  def prompt(user, entry)
    @entry = entry
    today  = I18n.l(user.in_time_zone(Time.zone.now), format: :for_prompt)

    mail(
      to: user.email,
      subject: "It's #{today}. How was your day?"
    )
  end
end
