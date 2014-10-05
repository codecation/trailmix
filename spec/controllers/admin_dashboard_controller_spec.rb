require "rails_helper"

describe AdminDashboardController do
  describe "#show" do
    context "when a logged out user requests it" do
      it "redirects" do
        get :show

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when a non-admin user requests it" do
      it "redirects" do
        non_admin = mock_model("User", email: "foo@bar.com")
        stub_current_user_with(non_admin)

        get :show

        expect(response).to redirect_to(dashboard_path)
      end
    end

    context "when an admin requests it" do
      it "renders successfully" do
        email = ENV.fetch("ADMIN_EMAILS").split(",").first
        admin = mock_model("User", email: email)
        stub_current_user_with(admin)

        get :show

        expect(response).to have_http_status(:success)
      end
    end
  end

  def stub_current_user_with(user)
    allow(controller).to(receive(:authenticate_user!))
    allow(controller).to(receive(:current_user).and_return(user))
  end
end
