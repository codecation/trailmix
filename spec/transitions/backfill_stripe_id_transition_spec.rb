describe BackfillStripeIdTransition do
  before do
    stub_stripe_customers
  end

  describe "#perform" do
    context "for users missing a Stripe ID" do
      it "fills in their Stripe ID" do
        first_user = create(:user, email: "first@example.com", stripe_id: nil)
        second_user = create(:user, email: "second@example.com", stripe_id: nil)

        BackfillStripeIdTransition.perform

        expect(first_user.reload.stripe_id).to eq("first id")
        expect(second_user.reload.stripe_id).to eq("second id")
      end
    end

    context "for users that already have a Stripe ID" do
      it "does nothing" do
        user = create(
          :user,
          email: "first@example.com",
          stripe_id: "original stripe id"
        )

        BackfillStripeIdTransition.perform

        expect(user.reload.stripe_id).to eq("original stripe id")
      end
    end
  end

  def stub_stripe_customers
    list = double("Stripe::ListObject")

    allow(list).to(receive(:each).and_yield(
      double("Stripe::Customer", email: "second@example.com", id: "second id")
    ).and_yield(
      double("Stripe::Customer", email: "first@example.com", id: "first id")
    ))

    allow(Stripe::Customer).to(receive(:all).and_return(list))
  end
end
