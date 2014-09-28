require "rails_helper"

describe SubscriptionsController, sidekiq: :inline do
  describe "#create" do
    before do
      stub_sign_in
    end

    context "with valid params" do
      it "creates a user, stripe customer, and email" do
        post :create, default_params

        expect(User.count).to eq(1)
        expect(FakeStripe.customer_count).to eq(1)
        expect(ActionMailer::Base.deliveries).not_to be_empty
      end
    end

    context "when the user is invalid" do
      it "does not create a new user or stripe customer" do
        stub_invalid_user

        post :create, default_params

        expect(User.count).to eq(0)
        expect(FakeStripe.customer_count).to eq(0)
      end
    end

    context "when the credit card fails to charge" do
      it "does not create a user or stripe customer" do
        stub_stripe_charge_failure

        post :create, default_params

        expect(User.count).to eq(0)
        expect(FakeStripe.customer_count).to eq(0)
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end

    def default_params
      {
        email: 'foo@bar.com',
        password: 'password',
        stripe_card_id: 'abc123'
      }
    end

    def stub_stripe_charge_failure
      error = Stripe::CardError.new(double, double, double)
      allow(error).to(receive(:message).and_return("Failed to charge card"))

      allow(Stripe::Customer).to(receive(:create).and_raise(error))
    end

    def stub_sign_in
      allow(controller).to receive(:sign_in)
    end

    def stub_invalid_user
      user = double("user",
                    valid?: false,
                    errors: double('errors').as_null_object)
      allow(User).to(receive(:new).and_return(user))
    end
  end
end
