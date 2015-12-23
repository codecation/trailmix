describe PromptEntry do
  describe "#best" do
    it "returns a random entry" do
      user = create(:user)
      random_entry = double(:entry)
      allow(user.entries).to(receive(:random).and_return(random_entry))

      best = PromptEntry.new(user.entries).best

      expect(best).to eq(random_entry)
    end
  end
end
