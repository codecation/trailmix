require "rails_helper"

describe PromptMailer do
  describe "#prompt" do
    it "has the correct headers" do
      Timecop.freeze(Time.utc(2014, 1, 1)) do
        entry = build_stubbed(:entry)
        user = build_stubbed(
          :user,
          time_zone: "UTC",
          reply_token: "abc123"
        )

        mail = PromptMailer.prompt(user, entry)

        expect(mail.to).to eq([user.email])
        expect(mail.from).to eq([user.reply_email])
        expect(mail.subject).to eq("It's Wednesday, Jan 1. How was your day?")
      end
    end

    context "when the user has set their timezone" do
      it "shows today's date in their timezone" do
        Timecop.freeze(Time.utc(2014, 1, 1, 20)) do
          user = create(:user, time_zone: "Guam") # UTC+10
          entry = build_stubbed(:entry)

          mail = PromptMailer.prompt(user, entry)

          expect(mail.subject).to include("Jan 2")
        end
      end
    end

    context "when the user has a previous entry" do
      it "includes a past entry" do
        user = create(:user)
        entry = create(:entry, user: user)

        mail = PromptMailer.prompt(user, entry)

        expect(mail.body.encoded).to include(entry.body)
      end

      it "says how long ago the past entry was in the user's time zone" do
        Timecop.freeze(Time.utc(2014, 1, 3, 14)) do
          user = create(:user, time_zone: "Guam") # UTC+10
          entry = create(:entry, user: user, date: Date.new(2014, 1, 1))

          mail = PromptMailer.prompt(user, entry)

          expect(mail.body.encoded).to include("3 days ago")
        end
      end
    end
  end

  context "when the user has no previous entries" do
    it "does not try to display the entry" do
      user = create(:user, entries: [])

      mail = PromptMailer.prompt(user, nil)

      expect(mail.body.encoded).to_not include("Remember this?")
    end
  end
end
