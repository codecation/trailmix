class EntriesController < ApplicationController
  def index
    if user_signed_in?
      @entries = current_user.entries.by_date.page(params[:page])
    else
      redirect_to new_registration_path
    end
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def update
    entry = Entry.find(params[:id])
    entry.update_attributes!(entry_params)

    redirect_to entries_path
  end

  private

  def entry_params
    params.require(:entry).permit(:body)
  end
end
