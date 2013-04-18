class CoursesController < ApplicationController
  before_filter :authorize

  def new
    @course = Course.new
  end

  def index
    
  end
end