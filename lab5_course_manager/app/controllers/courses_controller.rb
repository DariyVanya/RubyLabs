class CoursesController < ApplicationController
  before_action :set_course, only: %i[show edit update destroy]

  def index
    @courses_title = "All courses"
    @courses = Course.order(created_at: :desc)
  end

  def active
    @courses_title = "Active courses"
    @courses = Course.active.order(start_date: :asc)
    render :index
  end

  def drafts
    @courses_title = "Draft courses"
    @courses = Course.draft.order(created_at: :desc)
    render :index
  end

  def free
    @courses_title = "Free courses"
    @courses = Course.free.order(start_date: :asc)
    render :index
  end

  def starting_soon
    @courses_title = "Courses starting soon"
    @courses = Course.starting_soon.order(start_date: :asc)
    render :index
  end

  def show; end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      assign_instructors
      redirect_to @course, notice: "Course created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @course.update(course_params)
      assign_instructors
      redirect_to @course, notice: "Course updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path, notice: "Course deleted"
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :category, :client, :main_topic, :duration_hours, :description, :start_date, :end_date, :budget, :status)
  end

  def assign_instructors
    instructor_id = params.dig(:course, :instructor_id)
    return if instructor_id.blank?

    Instructor.find(instructor_id).update(course_id: @course.id)
  end
end
