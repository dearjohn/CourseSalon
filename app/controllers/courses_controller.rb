class CoursesController < ApplicationController
  before_filter :authorize
  
  def new
    @course = current_user.courses.build
  end

  def create
    @course = current_user.courses.build(params[:course])
    if @course.save
      flash[:success] = "New course!"
      render 'index'
    else
      flash[:fail] = "fail!"    	
      render 'new'
    end
  end

  def show
  	@course = Course.find(params[:id])		
  end
  
  def index
  end
end