describe SearchesController do
  describe "#show" do
    context "when signed out" do
      it "redirects to sign in" do
        get :show

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
