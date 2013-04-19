class CoursesController < ApplicationController
  before_filter :authorize
  
  def new
    @course = current_user.courses.build
  end

  def create
    @course = current_user.courses.build(params[:course])
    if @course.save
      flash[:success] = "New course!"
      redirect_to @course
    else
      flash[:fail] = "fail!"    	
      render 'new'
    end
  end

  def show
  	@course = Course.find(params[:id])		
  end
  
  def index
    @courses = Course.paginate( page: params[:page], 
      :per_page => 10, :order => 'created_at desc' ) #这里desc和asc控制升降  
  end
end