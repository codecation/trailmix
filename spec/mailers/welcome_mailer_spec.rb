describe WelcomeMailer do
  describe ".welcome"  do
    it "welcomes the user" do
      user = create(:user)
      mailer = WelcomeMailer.welcome(user)

      expect(mailer.body.encoded).to include("Welcome")
      expect(mailer.subject).to include("Write your first entry")
      expect(mailer.from).to eq(["today@trailmix.life"])
      expect(mailer.to).to eq([user.email])
    end
  end
end
