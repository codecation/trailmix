require "rails_helper"

describe PromptWorker do
  describe "#perform" do
    it "delivers an email" do
      user = create(:user)
      entry = create(:entry, user: user)
      mail = double("mail", deliver: nil)
      allow(PromptMailer).to(
        receive(:prompt).with(user, entry).and_return(mail)
      )

      PromptWorker.new.perform(user.id)

      expect(mail).to have_received(:deliver)
    end
  end
end
