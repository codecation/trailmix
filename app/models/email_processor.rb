class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    user.entries.create!(date: date, body: body)
  end

  private

  attr_reader :email

  def body
    EmailReplyParser.parse_reply(email.body)
  end

  def user
    @user ||= begin
      User.find_by(reply_token: reply_token) ||
      User.find_by!(email: from)
    end
  end

  def reply_token
    email.to.first[:token].downcase
  end

  def from
    email.from[:email].downcase
  end

  def date
    Date.parse(email.subject) rescue today
  end

  def today
    Time.zone.now.in_time_zone(user.time_zone)
  end
end
