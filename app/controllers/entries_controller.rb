class EntriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @entries = current_user.entries.by_date.page(params[:page])
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
