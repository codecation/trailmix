class SettingsController < ApplicationController
  layout "skinny"

  before_filter :authenticate_user!

  def edit
  end

  def update
    current_user.time_zone = params[:user][:time_zone]
    current_user.prompt_delivery_hour = params[:user][:prompt_delivery_hour]

    current_user.save!

    flash[:notice] = "Your settings have been saved."

    redirect_to dashboard_path
  end
end
