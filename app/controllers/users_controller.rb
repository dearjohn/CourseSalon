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
  		flash.now[:success] = "Hi, #{@user.name}. Have fun here!"
  		redirect_to @user
  	else
  		flash.now[:info] = "Do it again :)"
  		render 'new'
  	end
  end
end
