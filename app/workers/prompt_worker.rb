class PromptWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    entry = user.prompt_entry

    PromptMailer.prompt(user, entry).deliver_now
  end
end
