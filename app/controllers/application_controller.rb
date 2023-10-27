class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_current_user
  before_action :configure_registration_parameters, if: :devise_controller?

  protected

  def configure_registration_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :bio) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :bio, :password, :current_password)
    end
  end
end
