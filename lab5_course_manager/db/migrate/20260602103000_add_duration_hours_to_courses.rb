class AddDurationHoursToCourses < ActiveRecord::Migration[8.1]
  def change
    add_column :courses, :duration_hours, :integer, null: false, default: 0
  end
end