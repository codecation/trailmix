namespace :trailmix do
  desc "Delivers prompt emails for the current hour"
  task schedule_all_prompts: :environment do
    PromptTask.new(User.promptable.pluck(:id), PromptWorker).run
  end
end
