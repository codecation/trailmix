require 'fake_stripe'

RSpec.configure do |config|
  config.before(:each) do
    FakeStripe.stub_stripe
  end
end
