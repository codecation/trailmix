describe ExportsController do
  describe "#new" do
    context "when signed out" do
      it "redirects to sign in" do
        get :new

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
