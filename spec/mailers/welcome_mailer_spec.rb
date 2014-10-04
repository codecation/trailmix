describe WelcomeMailer do
  describe ".welcome"  do
    it "welcomes the user" do
      user = create(:user)

      mail = WelcomeMailer.welcome(user)

      expect(mail.body.encoded).to include("Welcome")
      expect(mail.subject).to include("Write your first entry")
      expect(mail.from).to eq([user.reply_email])
      expect(mail.to).to eq([user.email])
    end
  end
end
