require "rails_helper"

describe CancellationsController do
  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  describe "#create" do
    context "when signed in" do
      it "destroys the current user" do
        stripe_customer = Stripe::Customer.create
        subscription = create(:subscription, stripe_customer_id: stripe_customer.id)
        user = subscription.user

        sign_in(user)
        post :create, id: user.id

        expect(User.count).to be_zero
      end

      it "creates a Cancellation" do
        stripe_customer = Stripe::Customer.create
        subscription = create(:subscription, stripe_customer_id: stripe_customer.id)
        user = subscription.user

        sign_in(user)
        post :create, id: user.id, reason: "I'm done journaling"
        cancellation = Cancellation.last

        expect(cancellation.reason).to eq("I'm done journaling")
        expect(cancellation.stripe_customer_id).to(
          eq(subscription.stripe_customer_id)
        )
      end

      it "cancels the Stripe subscription" do
        subscription = create(:subscription)
        user = subscription.user
        stripe_subscription =
          stub_stripe(subscription.stripe_customer_id)
        sign_in(user)

        post :create, id: user.id

        expect(stripe_subscription).to(have_received(:delete))
      end
    end

    context "when signed out" do
      it "redirects to sign in" do
        post :create, id: "not an id"

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    def stub_stripe(customer_id)
      double("Stripe::Subscription", delete: true).tap do |subscription|
        customer = double(
          "Stripe::Customer",
          id: customer_id,
          subscriptions: [subscription]
        )

        allow(Stripe::Customer).to(
          receive(:retrieve).with(customer_id).and_return(customer)
        )
      end
    end
  end
end
