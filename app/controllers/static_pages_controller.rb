class StaticPagesController < ApplicationController
  def home
  	@tweet = current_user.tweets.build if signed_in?
  end

  def about
  end
end