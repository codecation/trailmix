class EntriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @entries = current_user.entries.by_date.page(params[:page])
  end

  def edit
    @entry = entry
  end

  def update
    entry.update!(entry_params)

    redirect_to entries_path
  end

  private

  def entry
    current_user.entries.find_by!(id: params[:id])
  end

  def entry_params
    params.require(:entry).permit(:body)
  end
end
