require "rails_helper"

describe CreditCardsController do
  it "requires authentication" do
    get :edit

    expect(response).to redirect_to(new_user_session_path)
  end
end
