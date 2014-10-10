require "rails_helper"

describe SubscriptionsController, sidekiq: :inline do
  describe "#create" do
    before do
      stub_sign_in
      stub_stripe_customer_create
    end

    context "with valid params" do
      it "creates a user, subscription, stripe customer, and email" do
        post :create, default_params

        expect(User.count).to eq(1)
        expect(Subscription.count).to eq(1)
        expect(Stripe::Customer).to(
          have_received(:create).with(
            email: default_params[:email],
            card: default_params[:stripe_card_id],
            plan: Rails.configuration.stripe[:plan_name]))
        expect(ActionMailer::Base.deliveries).not_to be_empty
      end

      it "saves the Stripe customer id on the subscription" do
        stripe_customer_id = "cus_123"
        stub_stripe_customer_create(stripe_customer_id)

        post :create, default_params
        subscription = Subscription.last

        expect(subscription.stripe_customer_id).to eq(stripe_customer_id)
      end
    end

    context "when the user is invalid" do
      it "does not create a new user, subscription, or stripe customer" do
        stub_invalid_user

        post :create, default_params

        expect(User.count).to eq(0)
        expect(Subscription.count).to eq(0)
        expect(FakeStripe.customer_count).to eq(0)
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end

    context "when the credit card fails to charge" do
      it "does not create a user, subscription, or stripe customer" do
        stub_stripe_charge_failure

        post :create, default_params

        expect(User.count).to eq(0)
        expect(Subscription.count).to eq(0)
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

    def stub_stripe_customer_create(stripe_customer_id = "cus_123")
      allow(Stripe::Customer).to(
        receive(:create).and_return(
          double("Stripe::Customer", id: stripe_customer_id)))
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
