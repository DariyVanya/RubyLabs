class CreateCategories < ActiveRecord::Migration[8.1]
  def change
    create_table :categories, if_not_exists: true do |t|
      t.string :name, null: false
      t.timestamps
    end

    add_index :categories, :name, unique: true unless index_exists?(:categories, :name)
  end
end
