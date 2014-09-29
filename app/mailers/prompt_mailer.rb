class PromptMailer < ActionMailer::Base
  def prompt(user, entry)
    @entry = entry

    mail(
      to: user.email,
      subject: "It's #{today(user)}. How was your day?"
    )
  end

  private

  def today(user)
    I18n.l(Time.zone.now.in_time_zone(user.time_zone), format: :for_prompt)
  end
end
