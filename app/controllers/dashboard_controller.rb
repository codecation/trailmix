class DashboardController < ApplicationController
  def index
    redirect_to new_registration_path unless user_signed_in?
  end
end
