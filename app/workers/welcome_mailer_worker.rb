class WelcomeMailerWorker < ApplicationJob
  def perform(user_id)
    user = User.find(user_id)

    WelcomeMailer.welcome(user).deliver_now
  end
end
