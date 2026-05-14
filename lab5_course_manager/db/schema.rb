# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_05_02_011300) do
  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "ingredients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_ingredients_on_name", unique: true
  end

  create_table "photos", force: :cascade do |t|
    t.string "caption", null: false
    t.datetime "created_at", null: false
    t.integer "recipe_id", null: false
    t.datetime "updated_at", null: false
    t.string "url", null: false
    t.index ["recipe_id"], name: "index_photos_on_recipe_id"
  end

  create_table "courses", force: :cascade do |t|
    t.decimal "budget", precision: 12, scale: 2, default: "0.0", null: false
    t.string "category"
    t.string "client", null: false
    t.datetime "created_at", null: false
    t.date "end_date"
    t.text "description"
    t.string "main_topic"
    t.date "start_date"
    t.integer "status", default: 0, null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.string "category"
    t.integer "cooking_time", default: 0, null: false
    t.datetime "created_at", null: false
    t.integer "difficulty", default: 0, null: false
    t.boolean "published", default: false, null: false
    t.integer "servings", default: 0, null: false
    t.text "steps"
    t.string "title", null: false
    t.datetime "updated_at", null: false
  end

  create_table "instructors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.integer "course_id", null: false
    t.string "role", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_instructors_on_course_id"
  end

  add_foreign_key "photos", "recipes"
  add_foreign_key "instructors", "courses"
end

