class SettingsController < ApplicationController
  layout "skinny"

  before_filter :authenticate_user!

  def edit
    @prompt_delivery_hour = user_prompt_delivery_hour
  end

  def update
    current_user.update_attributes(
      time_zone: params[:user][:time_zone],
      prompt_delivery_hour: utc_prompt_delivery_hour
    )

    flash[:notice] = "Your settings have been saved."

    redirect_to dashboard_path
  end

  private

  def user_prompt_delivery_hour
    current_user.prompt_delivery_hour + offset(current_user.time_zone)
  end

  def utc_prompt_delivery_hour
    params[:date][:prompt_delivery_hour].to_i -
    offset(params[:user][:time_zone])
  end

  def offset(time_zone)
    ActiveSupport::TimeZone[time_zone].utc_offset / 1.hour
  end
end
