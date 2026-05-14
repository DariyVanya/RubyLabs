class CreateCourses < ActiveRecord::Migration[8.1]
  def change
    create_table :courses do |t|
      t.string :title, null: false
      t.string :category
      t.string :main_topic
      t.integer :duration_hours, null: false, default: 0
      t.text :description
      t.date :start_date
      t.date :end_date
      t.decimal :price, precision: 12, scale: 2, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
