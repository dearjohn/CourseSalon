class ApplicationController < ActionController::Base
  protect_from_forgery

private 
	def current_user
   		@current_user ||= User.find_by_auth_token( cookies[:auth_token]) if cookies[:auth_token]
	end

  #因为在Rails中，helper的方法是可见的，所以在这里要将Controller里的方法设置为helper方法
  helper_method :current_user
  helper_method :authorize
  helper_method :signed_in?

  def authorize
  	redirect_to login_url, alert: "Not logged in. Please login first." if current_user.nil?
  end

  def signed_in?
    !current_user.nil?
  end

end