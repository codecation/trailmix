describe CreditCardsController, type: :controller do
  let(:stripe_helper) { StripeMock.create_test_helper }
  before { StripeMock.start }
  after { StripeMock.stop }

  describe "#update" do
    it "updates the credit card successfully" do
      stripe_customer = Stripe::Customer.create
      user = create(:user)
      create(:subscription, user: user, stripe_customer_id: stripe_customer.id)
      sign_in user

      payment_method = Stripe::PaymentMethod.create(
        type: "card",
        card: { token: stripe_helper.generate_card_token }
      )

      put :update, params: { stripe_payment_method_id: payment_method.id }

      expect(flash[:notice]).to eq("Credit card updated successfully")
      expect(response).to redirect_to(edit_credit_card_path)
    end
  end
end
