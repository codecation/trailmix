class SettingsController < ApplicationController
  layout "skinny"

  before_filter :authenticate_user!

  def edit
    offset = ActiveSupport::TimeZone[current_user.time_zone].utc_offset / 1.hour
    @prompt_delivery_hour = current_user.prompt_delivery_hour + offset
  end

  def update
    time_zone = params[:user][:time_zone]
    offset = ActiveSupport::TimeZone[time_zone].utc_offset / 1.hour
    prompt_delivery_hour = params[:date][:prompt_delivery_hour].to_i - offset

    current_user.update_attributes(
      time_zone: time_zone,
      prompt_delivery_hour: prompt_delivery_hour
    )

    flash[:notice] = "Your settings have been saved."

    redirect_to dashboard_path
  end
end
