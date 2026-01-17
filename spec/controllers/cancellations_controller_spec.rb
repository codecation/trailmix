
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
        post :create, params: { id: user.id }

        expect(User.count).to be_zero
      end

      it "creates a Cancellation" do
        stripe_customer = Stripe::Customer.create
        subscription = create(:subscription, stripe_customer_id: stripe_customer.id)
        user = subscription.user

        sign_in(user)
        post :create, params: { id: user.id, reason: "I'm done journaling" }
        cancellation = Cancellation.last

        expect(cancellation.reason).to eq("I'm done journaling")
        expect(cancellation.stripe_customer_id).to(
          eq(subscription.stripe_customer_id)
        )
      end

      it "cancels the Stripe subscription" do
        subscription = create(:subscription, stripe_subscription_id: "sub_123")
        user = subscription.user
        sign_in(user)

        allow(Stripe::Subscription).to receive(:cancel).and_return(true)

        post :create, params: { id: user.id }

        expect(Stripe::Subscription).to have_received(:cancel).with("sub_123")
      end
    end

    context "when signed out" do
      it "redirects to sign in" do
        post :create, params: { id: "not an id" }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
