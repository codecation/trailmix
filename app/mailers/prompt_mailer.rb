class PromptMailer < ActionMailer::Base
  PROMPT_TEXT = "How was your day?"

  def prompt(user, entry, date = nil)
    @entry = entry
    @date = date || Time.current.in_time_zone(user.time_zone).to_date
    @announcement = ENV["ANNOUNCEMENT"]

    mail(
      from: "Trailmix <#{user.reply_email}>",
      to: user.email,
      subject: Subject.new(user, @date)
    )
  end

  class Subject
    def initialize(user, date)
      @user = user
      @date = date
    end

    def to_s
      "It's #{date}. How was your day?"
    end

    private

    def date
      I18n.l(@date, format: :prompt_subject_line)
    end
  end
end
