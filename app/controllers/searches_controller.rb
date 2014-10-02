class SearchesController < ApplicationController
  before_filter :authenticate_user!

  def show
    @search = Search.new(search_params)
  end

  private

  def search_params
    permitted_params.fetch(:search, {}).merge(user: current_user)
  end

  def permitted_params
    params.permit(:commit, :utf8, search: :term)
  end
end
