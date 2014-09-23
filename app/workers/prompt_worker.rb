class PromptWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    entry = user.random_entry

    PromptMailer.prompt(user, entry).deliver
  end
end
