class PagesController < ApplicationController
  def show
    render template: "pages/#{params[:id]}"
  rescue ActionView::MissingTemplate
    raise ActionController::RoutingError, "Not Found"
  end
end
