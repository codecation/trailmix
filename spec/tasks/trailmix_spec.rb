require "rake"

describe "trailmix:schedule_all_prompts", sidekiq: :inline do
  before do
    load "tasks/trailmix.rake"
    Rake::Task.define_task(:environment)
  end

  it "sends prompts to all users that would like a prompt" do
    Timecop.freeze(Time.utc(2014, 1, 1, 8)) do # 8AM UTC
      create(:user, time_zone: "UTC", prompt_delivery_hour: 7)
      utc_8am = create(:user, time_zone: "UTC", prompt_delivery_hour: 8)
      arz_1am = create(:user, time_zone: "Arizona", prompt_delivery_hour: 1)
      create(:user, time_zone: "UTC", prompt_delivery_hour: 9)

      Rake::Task["trailmix:schedule_all_prompts"].invoke

      expect(emailed_addresses).to contain_exactly(utc_8am.email, arz_1am.email)
    end
  end

  def emailed_addresses
    ActionMailer::Base.deliveries.map(&:to).flatten
  end
end
