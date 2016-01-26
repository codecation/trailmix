class CancellationsController < ApplicationController
  before_action :authenticate_user!

  def create
    create_cancellation
    current_user.destroy!
    flash[:notice] = "Your account has been removed and " +
      "your subscription has been canceled."

    redirect_to new_registration_path
  end

  private

  def create_cancellation
    Cancellation.create!(email: current_user.email,
                         stripe_customer_id: current_user.stripe_customer_id,
                         reason: params[:reason])
  end
end
