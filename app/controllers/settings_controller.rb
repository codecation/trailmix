class SettingsController < ApplicationController
  layout "skinny"

  before_filter :authenticate_user!

  def edit
  end

  def update
    current_user.update_attribute :time_zone, params[:user][:time_zone]

    flash[:notice] = "Your settings have been saved."

    redirect_to dashboard_path
  end
end
