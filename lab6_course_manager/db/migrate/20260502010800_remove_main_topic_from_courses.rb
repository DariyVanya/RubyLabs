class RemoveMainTopicFromCourses < ActiveRecord::Migration[8.1]
  def change
    remove_column :courses, :main_topic, :string if column_exists?(:courses, :main_topic)
  end
end