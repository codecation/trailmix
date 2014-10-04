describe FillInReplyTokensTransition do
  it "creates a reply token for all users missing a reply token" do
    users = [create(:user), create(:user)]
    users.each { |user| user.update_attribute(:reply_token, nil) }

    FillInReplyTokensTransition.new.perform

    users.each { |user| expect(user.reload.reply_token).to_not be_nil }
  end

  it "does not mess with existing reply tokens" do
    existing_reply_token = "abc123"
    user = create(:user, reply_token: existing_reply_token)

    FillInReplyTokensTransition.new.perform

    expect(user.reload.reply_token).to eq existing_reply_token
  end
end
