class CreateWorkoutExercises < ActiveRecord::Migration[8.1]
  def change
    create_table :workout_exercises do |t|
      t.string :name
      t.string :exercise_type, null: false, default: "weights"
      t.references :exercise, null: false, foreign_key: true
      t.references :workout, null: false, foreign_key: true
      t.timestamps
    end
  end
end
