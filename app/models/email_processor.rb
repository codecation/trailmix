class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    AmendableEntry.create!(user: user, date: date, body: body)
  end

  private

  attr_reader :email

  def body
    EmailReplyParser.parse_reply(email.body)
  end

  def user
    @user ||= User.find_by!(reply_token: reply_token)
  end

  def reply_token
    email.to.first[:token].downcase
  end

  def date
    Date.parse(email.subject) rescue today
  end

  def today
    Time.zone.now.in_time_zone(user.time_zone)
  end
end
