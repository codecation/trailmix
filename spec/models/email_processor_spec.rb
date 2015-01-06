describe EmailProcessor do
  describe "#process" do
    it "creates an entry based on the email token" do
      user = create(:user)
      email = create(
        :griddler_email,
        to: [{ token: user.reply_token }],
        body: "I am great"
      )

      EmailProcessor.new(email).process

      expect(user.newest_entry.body).to eq("I am great")
    end

    it "creates an entry even if the email token is uppercase" do
      user = create(:user)
      email = create(
        :griddler_email,
        to: [{ token: user.reply_token.upcase }],
        body: "I am great"
      )

      EmailProcessor.new(email).process

      expect(user.newest_entry.body).to eq("I am great")
    end

    it "parses the email body with an email reply parser" do
      user = create(:user)
      email = create(:griddler_email, to: [{ token: user.reply_token }])

      expect(EmailReplyParser).to(
        receive(:parse_reply).with(email.body).and_return(""))

      EmailProcessor.new(email).process
    end

    it "amends existing entries" do
      Timecop.freeze(2014, 1, 1) do
        today = Date.current
        user = create(:user)
        email = create(
          :griddler_email,
          to: [{ token: user.reply_token }],
          body: "I am great"
        )
        allow(AmendableEntry).to(receive(:create!))

        EmailProcessor.new(email).process

        expect(AmendableEntry).to(have_received(:create!).with(
          user: user,
          date: today,
          body: email.body
        ))
      end
    end

    context "when a user can't be found" do
      it "raises an exception" do
        user = create(:user)
        email = create(:griddler_email, to: [{ token: "not-a-token" }])

        expect do
          EmailProcessor.new(email).process
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "when the entry can't be created" do
      it "raises an exception" do
        user = create(:user)
        email = create(:griddler_email)

        allow(user.entries).to receive(:create!).and_raise

        expect do
          EmailProcessor.new(email).process
        end.to raise_error(ActiveRecord::ActiveRecordError)
      end
    end

    it "sets the entry date to today's date in the user's time zone" do
      Timecop.freeze(2014, 1, 1, 20) do # 8 PM UTC
        user = create(:user, time_zone: "Guam") # UTC+10
        email = create(:griddler_email, to: [{ token: user.reply_token }])

        EmailProcessor.new(email).process

        expect(user.newest_entry.date).to eq(Date.new(2014, 1, 2))
      end
    end

    context "when the entry is a response to a past day's email" do
      pending "sets the entry date to the email's date" do
        past_day = Date.new(2014, 1, 2)
        Timecop.freeze(2015, 1, 1) do
          user = create(:user)
          email = create(
            :griddler_email,
            to: [{ token: user.reply_token }],
            subject: "Re: #{PromptMailer::Subject.new(user, past_day)}"
          )

          EmailProcessor.new(email).process

          expect(user.newest_entry.date).to eq(past_day)
        end
      end
    end
  end
end
