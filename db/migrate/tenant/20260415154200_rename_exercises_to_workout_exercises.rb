class RenameExercisesToWorkoutExercises < ActiveRecord::Migration[8.1]
  def change
    rename_table :exercises, :workout_exercises

    rename_column :weight_sets, :exercise_id, :workout_exercise_id
    rename_column :cardio_sets, :exercise_id, :workout_exercise_id
  end
end
