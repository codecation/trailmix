class FillInReplyTokensTransition
  def perform
    User.find_each do |user|
      user.generate_reply_token
      user.save!
    end
  end
end
