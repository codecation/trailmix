class ImportsController < ApplicationController
  def new
    @import = Import.new
  end

  def create
    import = Import.new(import_params.merge(user: current_user))

    if import.save
      OhlifeImporter.new(current_user, import).run

      flash[:notice] = "Import complete!"
      redirect_to dashboard_path
    else
      flash[:error] = "Only text files can be uploaded"
      redirect_to new_import_path
    end
  end

  private

  def import_params
    params.require(:import).permit(:raw_file)
  end
end
