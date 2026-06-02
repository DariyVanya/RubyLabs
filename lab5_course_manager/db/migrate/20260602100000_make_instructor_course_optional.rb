class MakeInstructorCourseOptional < ActiveRecord::Migration[8.1]
  def change
    change_column_null :instructors, :course_id, true
  end
end