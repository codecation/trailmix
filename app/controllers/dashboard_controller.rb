class DashboardController < ApplicationController
  def index
    if user_signed_in?
      @entries = current_user.entries.page(params[:page])
    else
      redirect_to new_registration_path unless user_signed_in?
    end
  end
end
