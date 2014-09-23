namespace :trailmix do
  desc "Delivers all prompt emails"
  task schedule_all_prompts: :environment do
    PromptTask.new(User.all, PromptWorker).run
  end
end
