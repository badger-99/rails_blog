class ApplicationController < ActionController::Base
  # before_action :set_current_user

  def set_current_user
    @current_user = current_user
  end

  private

  def current_user
    @_current_user = User.first
  end
end
