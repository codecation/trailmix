describe SettingsController do
  describe "#edit" do
    context "when signed out" do
      it "redirects to sign in" do
        get :edit

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
