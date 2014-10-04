class FillInReplyTokensTransition
  def perform
    users.find_each do |user|
      user.generate_reply_token
      user.save!
    end
  end

  private

  def users
    User.where(reply_token: nil)
  end
end
