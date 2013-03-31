class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      if params[:auth_token]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      redirect_to root_url
      flash[:success] = "Logged in."
      end
    else
      flash[:error] = "Email or password is invalid."
      redirect_to login_url
    end
  end

  def destroy
    cookies.delete(:auth_token)  #陷阱！不是中括号！！！
    redirect_to root_url
    flash[:success] = "Logged out."
  end
end
