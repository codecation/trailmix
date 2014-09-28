class SettingsController < ApplicationController
  layout "skinny"

  before_filter :authenticate_user!

  def edit
  end

  def update
    current_user.update_attributes(
      time_zone: params[:user][:time_zone],
      prompt_delivery_hour: params[:date][:prompt_delivery_hour],
    )

    flash[:notice] = "Your settings have been saved."

    redirect_to dashboard_path
  end
end
