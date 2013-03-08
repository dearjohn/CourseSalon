class ApplicationController < ActionController::Base
  protect_from_forgery



private
  def current_user
  	@current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

=begin 用来验证权限的authorize方法
  def authorize
  	redirect_to login_url, alert: "Not logged in." if current_user.nil?
  end
=end
end