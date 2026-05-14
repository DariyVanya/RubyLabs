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

ActiveRecord::Schema[8.1].define(version: 2026_05_02_012400) do
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
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.date "end_date"
    t.text "description"
    t.integer "duration_hours", default: 0, null: false
    t.date "start_date"
    t.integer "status", default: 0, null: false
    t.decimal "price", precision: 12, scale: 2, default: "0.0", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_courses_on_category_id"
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "ingredient_id", null: false
    t.integer "recipe_id", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "cooking_time", default: 0, null: false
    t.datetime "created_at", null: false
    t.integer "difficulty", default: 0, null: false
    t.boolean "published", default: false, null: false
    t.integer "servings", default: 0, null: false
    t.text "steps"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_recipes_on_category_id"
  end

  create_table "course_topics", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "course_id", null: false
    t.integer "topic_id", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_topics_on_course_id"
    t.index ["topic_id"], name: "index_course_topics_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_topics_on_name", unique: true
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
  add_foreign_key "courses", "categories"
  add_foreign_key "recipe_ingredients", "ingredients"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "recipes", "categories"
  add_foreign_key "course_topics", "courses"
  add_foreign_key "course_topics", "topics"
  add_foreign_key "instructors", "courses"
end

