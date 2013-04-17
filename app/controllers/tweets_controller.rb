class TweetsController < ApplicationController
  before_filter :authorize, only: [:create, :destroy]
  
  def create
    @tweet = current_user.tweets.build(params[:tweet])
    if @tweet.save
      flash[:success] = "New tweet!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  #Tutorial中说这种删除方法不安全？
  def destroy
    current_user.tweets.find_by_id(params[:id]).destroy
    redirect_to root_url
  end

end