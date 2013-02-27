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
  		flash[:success] = "Hi, #{@user.name}. Have fun here!"
  		redirect_to @user
  	else
  		flash[:info] = "Do it again :)"
  		render 'new'
  	end
  end
end
