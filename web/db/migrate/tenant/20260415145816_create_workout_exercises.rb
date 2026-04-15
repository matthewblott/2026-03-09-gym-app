class CreateWorkoutExercises < ActiveRecord::Migration[8.1]
  def change
    create_table :workout_exercises do |t|
      t.references :exercise, null: false, foreign_key: true
      t.references :workout, null: false, foreign_key: true
      t.integer :order, default: 0

      t.timestamps
    end

    add_index :workout_exercises, %i[workout_id order]
  end
end
