require "spec_helper"

describe LandingController do
  render_views

  describe "#show" do
    context "when the user is signed out" do
      it "renders the landing page" do
        get :show

        expect(response).to have_http_status(:ok)
        expect(response.body).to include("That's why we built Trailmix")
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
