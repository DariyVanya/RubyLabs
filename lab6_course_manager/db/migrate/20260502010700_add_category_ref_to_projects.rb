class AddCategoryRefToCourses < ActiveRecord::Migration[8.1]
  def change
    remove_column :courses, :category, :string if column_exists?(:courses, :category)

    unless column_exists?(:courses, :category_id)
      add_reference :courses, :category, foreign_key: true
    end
  end
end
