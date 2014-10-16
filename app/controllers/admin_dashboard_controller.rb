class AdminDashboardController < ApplicationController
  before_filter :authenticate_user!, :restrict_to_admins

  def show
    @dashboard = AdminDashboard.new
  end

  private

  def restrict_to_admins
    unless admin_emails.include?(current_user.email)
      redirect_to entries_path
    end
  end

  def admin_emails
    ENV.fetch("ADMIN_EMAILS").split(",")
  end
end
