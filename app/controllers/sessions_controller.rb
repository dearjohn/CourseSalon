class SessionsController < ApplicationController

  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to user
  		flash[:success] = "Logged in."
  	else
      flash[:error] = "Email or password is invalid."
  		redirect_to login_url
  	end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
    flash[:success] = "Logged out."
  end
end
