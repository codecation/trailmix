class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    user = User.find_by!(email: @email.from[:email])

    user.entries.create(body: @email.body)
  end
end
