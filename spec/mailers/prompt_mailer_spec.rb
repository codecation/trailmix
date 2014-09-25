require "rails_helper"

describe PromptMailer do
  describe "#prompt" do
    it "has the correct headers" do
      Timecop.freeze do
        user = build_stubbed(:user)
        entry = build_stubbed(:entry)

        mail = PromptMailer.prompt(user, entry)

        expect(mail.to).to eq([user.email])
        expect(mail.from).to eq(["today@#{ENV.fetch('SMTP_DOMAIN')}"])
        expect(mail.subject).to eq("It's #{I18n.l(Date.today, format: :for_prompt)}. How was your day?")
      end
    end

    context "when the user has a previous entry" do
      it "includes a past entry" do
        user = create(:user)
        entry = create(:entry, user: user)

        mail = PromptMailer.prompt(user, entry)

        expect(mail.body.encoded).to include(entry.body)
      end

      it "says how long ago the past entry was" do
        user = create(:user)
        entry = create(:entry, user: user, created_at: 1.day.ago)

        mail = PromptMailer.prompt(user, entry)

        expect(mail.body.encoded).to include("1 day ago")
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
