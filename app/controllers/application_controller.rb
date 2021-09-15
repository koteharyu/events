class ApplicationController < ActionController::Base
  add_flash_types :success, :danger
  helper_method :logged_in?, :current_user
  before_action :authenticate

  private

  def logged_in?
    !!current_user
  end

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end

  def authenticate
    return if logged_in?
    redirect_to root_path, danger: "ログインしてね"
  end
end
