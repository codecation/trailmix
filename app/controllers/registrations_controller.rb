class RegistrationsController < Devise::RegistrationsController
  def create
    super

    if @user.persisted?
      WelcomeMailer.welcome(@user).deliver
    end
  end

  protected

  def after_sign_up_path_for(_)
    dashboard_path
  end
end
