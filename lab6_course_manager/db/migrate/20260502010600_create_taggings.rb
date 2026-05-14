class CreateCourseTopics < ActiveRecord::Migration[8.1]
  def change
    create_table :course_topics do |t|
      t.references :course, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true
      t.timestamps
    end
  end
end
