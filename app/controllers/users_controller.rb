class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      cookies.permanent[:auth_token] = @user.auth_token
  #   UserMailer.signup_confirmation(@user).deliver
      flash[:success] = "Hi, #{@user.name}. Have fun here!"
      redirect_to @user
    else
      render 'new'
    end
  end
end