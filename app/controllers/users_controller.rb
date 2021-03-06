class UsersController < ApplicationController
  before_filter :authorize, only: [:edit, :update, :index, :following, :followers]
  
  def new
    @user = User.new
  end

  def show
    authorize
    @user = User.find(params[:id])
    @tweets = @user.tweets.paginate(page: params[:page],
      :per_page => 10, :order => 'created_at desc')
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      cookies.permanent[:auth_token] = @user.auth_token
  #   UserMailer.signup_confirmation(@user).deliver
      flash[:success] = "Hi, #{@user.name}. Have fun here!"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id #控制修改权限，如果放在view里面会麻烦
      flash[:fail] = "You can only update your profile!"
      redirect_to current_user
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      cookies[:auth_token] = @user.auth_token
      flash[:success] = "Your profile has been updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate( page: params[:page], 
      :per_page => 10, :order => 'created_at desc' ) #这里desc和asc控制升降
  end

  def following
    @title = "Users i'm following : "
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'follow_details'
  end

  def followers
    @title = "My followers : "
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'follow_details'
  end
end