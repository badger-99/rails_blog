class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user

  def set_current_user
    @current_user = configure_current_user
  end

  private

  def configure_current_user
    @the_user = current_user
  end
end
