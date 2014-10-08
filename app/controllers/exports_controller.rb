class ExportsController < ApplicationController
  before_filter :authenticate_user!

  def new
    export = Export.new(current_user)

    send_data export.to_json, filename: export.filename
  end
end
