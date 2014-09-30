require "rails_helper"

feature "The server executes the prompt task", sidekiq: :inline do
  scenario "and all users are emailed" do
    first_user = create(:user)
    second_user = create(:user)
    third_user = create(:user)
    users = [first_user, second_user, third_user]

    PromptTask.new(User.pluck(:id), PromptWorker).run

    users.each do |user|
      expect(emailed_addresses).to include(user.email)
    end
  end

  def emailed_addresses
    ActionMailer::Base.deliveries.map(&:to).flatten
  end
end
