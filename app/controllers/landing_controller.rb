class LandingController < ApplicationController
  def show
    if signed_in?
      redirect_to entries_path
    end
  end
end
