require "spec_helper"

describe LandingController do
  describe "#show" do
    context "when the user is signed out" do
      it "renders the landing page" do
        get :show

        expect(response).to render_template :show
      end
    end

    context "when the user is signed in" do
      it "redirects to the entries index" do
        user = create(:user)
        sign_in(user)

        get :show

        expect(response).to redirect_to entries_path
      end
    end
  end
end
