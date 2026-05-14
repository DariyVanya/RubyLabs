class CreatePhotos < ActiveRecord::Migration[8.1]
  def change
    create_table :photos do |t|
      t.string :caption, null: false
      t.string :url, null: false
      t.references :recipe, null: false, foreign_key: true
      t.timestamps
    end
  end
end
