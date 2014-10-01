describe EmailProcessor do
  describe "#process" do
    it "creates an entry based on the email" do
      user = create(:user)
      email = double('email', from: { email: user.email }, body: "I am great")

      EmailProcessor.new(email).process

      expect(user.newest_entry.body).to eq("I am great")
    end

    it "creates an entry even if the email address is uppercase" do
      user = create(:user)
      email = double(
        "email",
        from: { email: user.email.upcase },
        body: "I am great"
      )

      EmailProcessor.new(email).process

      expect(user.newest_entry.body).to eq("I am great")
    end

    context "when a user can't be found" do
      it "raises an exception" do
        user = create(:user)
        email = double('email', from: { email: "nobody@example.com" })

        expect do
          EmailProcessor.new(email).process
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when the entry can't be created" do
      it "raises an exception" do
        user = create(:user)
        email = double('email', from: { email: user.email }, body: nil)

        expect do
          EmailProcessor.new(email).process
        end.to raise_error(ActiveRecord::ActiveRecordError)
      end
    end
  end
end
