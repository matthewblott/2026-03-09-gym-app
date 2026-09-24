class CreateWeightSets < ActiveRecord::Migration[8.1]
  def change
    create_table :weight_sets do |t|
      t.references :workout_exercise, null: false, foreign_key: true
      t.integer :reps
      t.integer :weight
      t.timestamps
    end
  end
end
