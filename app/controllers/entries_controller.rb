class EntriesController < ApplicationController
  def index
    if user_signed_in?
      @entries = current_user.entries.by_date.page(params[:page])
    else
      redirect_to new_registration_path
    end
  end
end
