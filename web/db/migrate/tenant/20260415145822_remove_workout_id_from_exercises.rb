class RemoveWorkoutIdFromExercises < ActiveRecord::Migration[8.1]
  def change
    remove_reference :exercises, :workout, foreign_key: true
  end
end
