class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    user.entries.create!(body: @email.body)
  end

  private

  def user
    User.find_by!(email: @email.from[:email].downcase)
  end
end
