module ReplyToken
  def self.included(klass)
    klass.before_create :generate_reply_token
  end

  def generate_reply_token
    unless reply_token
      self.reply_token = loop do
        token = new_reply_token
        break token unless token_exists?(token)
      end
    end
  end

  private

  def token_exists?(token)
    self.class.exists?(reply_token: token)
  end

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
