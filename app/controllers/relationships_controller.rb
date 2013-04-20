class RelationshipsController < ApplicationController
  before_filter :authorize

  #关注的列表relationships的操作借鉴tutorial的实现
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    redirect_to @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    redirect_to @user
  end
end