class ReplyToken
  def initialize(email)
    @email = email
  end

  def generate
    new_reply_token
  end

  private

  attr_reader :email

  def new_reply_token
    "#{username}.#{random_suffix}".downcase
  end

  def random_suffix
    SecureRandom.urlsafe_base64(8)
  end

  def username
    email.split("@").first
  end
end
