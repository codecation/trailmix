class ImportsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @import = Import.new
  end

  def create
    import = Import.new(import_params.merge(user: current_user))

    if import.save
      OhlifeImportWorker.perform_async(current_user.id, import.id)

      flash[:notice] = "We're importing your entries. Try refreshing the page "\
                       "in a few seconds."
      redirect_to entries_path
    else
      flash[:error] = "Sorry, we had trouble importing that. :( Need help? "\
                      "Contact us at team@trailmix.life"
      redirect_to new_import_path
    end
  end

  private

  def import_params
    params.require(:import).permit(:ohlife_export)
  end
end
