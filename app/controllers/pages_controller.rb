class PagesController < ApplicationController
  
  def home
  	#这里提供给home页面发tweet的模板
  	if signed_in?
      @tweet  = current_user.tweets.build
      @feed_items = current_user.feed.paginate(page: params[:page],
      	:per_page => 10, :order => 'created_at desc')
    end
  end

  def about
  end
end