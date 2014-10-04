class ReplyToken
  def initialize(email)
    @email = email
  end

  def self.generate(email)
    new(email).generate
  end

  def generate
    "#{username}.#{random_suffix}".downcase
  end

  private

  attr_reader :email

  def random_suffix
    SecureRandom.urlsafe_base64(8)
  end

  def username
    email.split("@").first
  end
end
