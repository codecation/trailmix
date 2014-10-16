class SettingsController < ApplicationController
  layout "skinny"

  before_filter :authenticate_user!

  def edit
  end

  def update
    current_user.update_attributes!(user_params)

    flash[:notice] = "Your settings have been saved."

    redirect_to entries_path
  end

  private

  def user_params
    params.require(:user).permit(:time_zone, :prompt_delivery_hour)
  end
end
