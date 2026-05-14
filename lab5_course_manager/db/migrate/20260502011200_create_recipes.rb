class CreateRecipes < ActiveRecord::Migration[8.1]
  def change
    create_table :recipes do |t|
      t.string :title, null: false
      t.string :category
      t.integer :cooking_time, null: false, default: 0
      t.integer :servings, null: false, default: 0
      t.integer :difficulty, null: false, default: 0
      t.boolean :published, null: false, default: false
      t.text :steps
      t.timestamps
    end
  end
end
