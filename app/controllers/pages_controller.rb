class PagesController < ApplicationController
  def show
    raise ActionController::RoutingError, "Not Found" unless params[:id].match?(/\A[a-z0-9\-]+\z/)
    render template: "pages/#{params[:id]}"
  rescue ActionView::MissingTemplate
    raise ActionController::RoutingError, "Not Found"
  end
end
