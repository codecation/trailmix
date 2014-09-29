class PromptMailer < ActionMailer::Base
  def prompt(user, entry)
    @entry = entry
    today  = I18n.l(
      Time.zone.now.in_time_zone(user.time_zone),
      format: :for_prompt
    )

    mail(
      to: user.email,
      subject: "It's #{today}. How was your day?"
    )
  end
end
