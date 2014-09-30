describe PromptTask do
  describe "#run" do
    it "enqueues a job for each user" do
      user = double("user", id: 1)
      other_user = double("other_user", id: 2)
      worker = double("worker", perform_async: nil)

      PromptTask.new([1, 2], worker).run

      expect(worker).to have_received(:perform_async).with(user.id)
      expect(worker).to have_received(:perform_async).with(other_user.id)
    end
  end
end
