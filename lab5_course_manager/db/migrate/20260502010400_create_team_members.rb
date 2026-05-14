class CreateInstructors < ActiveRecord::Migration[8.1]
  def change
    create_table :instructors do |t|
      t.string :name, null: false
      t.string :role, null: false
      t.references :course, null: false, foreign_key: true
      t.timestamps
    end
  end
end
