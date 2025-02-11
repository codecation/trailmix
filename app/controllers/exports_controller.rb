class ExportsController < ApplicationController
  before_action :authenticate_user!

  def new
    export = Export.new(current_user)

    send_data export.to_json, filename: export.filename
  end
end
