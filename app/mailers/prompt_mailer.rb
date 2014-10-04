class PromptMailer < ActionMailer::Base
  def prompt(user, entry)
    @entry = entry

    mail(
      from: "Trailmix <#{user.reply_email}>",
      to: user.email,
      subject: Subject.new(user)
    )
  end

  class Subject
    def initialize(user, date = Time.zone.now)
      @user = user
      @date = date
    end

    def to_s
      "It's #{today}. How was your day?"
    end

    private

    def today
      I18n.l(@date.in_time_zone(@user.time_zone), format: :for_prompt)
    end
  end
end
