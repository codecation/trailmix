require "active_job/test_helper"

RSpec.configure do |config|
  config.include ActiveJob::TestHelper

  config.before do
    clear_enqueued_jobs
    clear_performed_jobs
  end

  config.around(active_job: :inline) do |example|
    perform_enqueued_jobs { example.run }
  end
end
