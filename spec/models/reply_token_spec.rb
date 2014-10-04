describe ReplyToken do
  describe "#generate" do
    it "generates a unique token" do
      reply_token = ReplyToken.new("username@example.com")

      first_token  = reply_token.generate
      second_token = reply_token.generate

      expect(first_token).to_not eq second_token
    end

    it "includes the email username at the beginning of the token" do
      reply_token = ReplyToken.new("username@example.com")

      token = reply_token.generate

      expect(token).to start_with "username"
    end
  end
end
