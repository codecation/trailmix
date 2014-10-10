describe BackfillSubscriptionsTransition do
  describe "#perform" do
    context "for users missing a Subscription" do
      it "creates one with the correct Stripe customer id" do
        first_user = create(:user, subscription: nil)
        second_user = create(:user, subscription: nil)
        stub_stripe_customers([
          { email: first_user.email, id: "first id" },
          { email: second_user.email, id: "second id" }
        ])

        BackfillSubscriptionsTransition.perform

        first_subscription = first_user.reload.subscription
        second_subscription = second_user.reload.subscription

        expect(first_subscription.stripe_customer_id).to eq("first id")
        expect(second_subscription.stripe_customer_id).to eq("second id")
      end
    end

    context "for users that already have a Subscription" do
      it "does nothing" do
        original_subscription = create(:subscription)
        user = create(:user, subscription: original_subscription)
        stub_stripe_customers([
          { email: user.email, id: "new id" }
        ])

        BackfillSubscriptionsTransition.perform

        expect(user.reload.subscription).to eq(original_subscription)
      end
    end
  end

  def stub_stripe_customers(customers)
    customer_list = double("Stripe::ListObject")
    iterator = allow(customer_list).to(receive(:each))

    customers.inject(iterator) do |iterator, customer|
      iterator.and_yield(
        double("Stripe::Customer", email: customer[:email], id: customer[:id]))
    end

    allow(Stripe::Customer).to(receive(:all).and_return(customer_list))
  end
end
