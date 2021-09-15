class ApplicationController < ActionController::Base
  add_flash_types :success, :danger
  helper_method :logged_in?

  private

  def logged_in?
    !!session[:user_id]
  end
end
