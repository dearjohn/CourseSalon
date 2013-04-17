class TweetsController < ApplicationController
  before_filter :authorize, only: [:create, :destroy]

  def create
    @tweet = current_user.tweets.build(params[:tweet])
    if @tweet.save
      flash[:success] = "New tweet!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end
end