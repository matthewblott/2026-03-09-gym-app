class CreateExerciseSets < ActiveRecord::Migration[8.1]
  def change
    create_table :exercise_sets do |t|
      t.integer :reps
      t.decimal :weight
      t.references :exercise, null: false, foreign_key: true
      t.timestamps
    end
  end
end
