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

ActiveRecord::Schema[8.1].define(version: 2026_04_15_154200) do
  create_table "cardio_sets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.decimal "distance"
    t.integer "duration_seconds"
    t.datetime "updated_at", null: false
    t.integer "workout_exercise_id", null: false
    t.index ["workout_exercise_id"], name: "index_cardio_sets_on_workout_exercise_id"
  end

  create_table "weight_sets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "reps"
    t.datetime "updated_at", null: false
    t.decimal "weight"
    t.integer "workout_exercise_id", null: false
    t.index ["workout_exercise_id"], name: "index_weight_sets_on_workout_exercise_id"
  end

  create_table "workout_exercises", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "exercise_type", default: "weights", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.integer "workout_id", null: false
    t.index ["workout_id"], name: "index_workout_exercises_on_workout_id"
  end

  create_table "workouts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "title"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cardio_sets", "workout_exercises"
  add_foreign_key "weight_sets", "workout_exercises"
  add_foreign_key "workout_exercises", "workouts"
end
