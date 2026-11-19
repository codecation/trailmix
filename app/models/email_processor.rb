class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    entry = Entry.find_or_initialize_by(user: user, date: date)
    entry.update!(body: body, photo: attachment)
  end

  private

  attr_reader :email

  def body
    EmailReplyParser.parse_reply(email.body)
  end

  def user
    @user ||= User.find_by!(reply_token: reply_token)
  end

  def attachment
    Array(email.attachments).find do |file|
      file.content_type.to_s.match?(PhotoUploader::ALLOWED_CONTENT_TYPES)
    end
  end

  def reply_token
    email.to.first[:token].downcase
  end

  def date
    date = Date.parse(email.subject)
    date.future? ? (date - 1.year) : date
  rescue
    today
  end

  def today
    Time.zone.now.in_time_zone(user.time_zone)
  end
end
