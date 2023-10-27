class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user
  before_action :configure_registration_parameters, if: :devise_controller?

  def set_current_user
    @current_user = configure_current_user
  end

  protected

  def configure_registration_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
  end

  private

  def configure_current_user
    @the_user = current_user
  end
end
