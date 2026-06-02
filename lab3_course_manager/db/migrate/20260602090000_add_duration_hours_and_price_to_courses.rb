class AddDurationHoursAndPriceToCourses < ActiveRecord::Migration[8.1]
  def change
    add_column :courses, :duration_hours, :integer
    add_column :courses, :price, :decimal, precision: 12, scale: 2, default: 0.0, null: false
  end
end