class InstructorsController < ApplicationController
  before_action :set_instructor, only: %i[show edit update destroy]

  def index
    @instructors = Instructor.includes(:course).order(:name)
  end

  def show; end

  def new
    @instructor = Instructor.new
  end

  def create
    @instructor = Instructor.new(instructor_params)
    if @instructor.save
      redirect_to @instructor, notice: "Instructor created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @instructor.update(instructor_params)
      redirect_to @instructor, notice: "Instructor updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @instructor.destroy
    redirect_to instructors_path, notice: "Instructor deleted"
  end

  private

  def set_instructor
    @instructor = Instructor.find(params[:id])
  end

  def instructor_params
    params.require(:instructor).permit(:name, :role, :course_id)
  end
end
