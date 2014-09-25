class ImportsController < ApplicationController
  def new
    @import = Import.new
  end

  def create
    import = Import.create!(import_params.merge(user: current_user))
    OhlifeImporter.new(current_user, import).run

    flash[:notice] = "Import complete!"
    redirect_to dashboard_path
  end

  private

  def import_params
    params.require(:import).permit(:raw_file)
  end
end
