class WelcomeMailerWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)

    WelcomeMailer.welcome(user).deliver
  end
end
