class CreateWeightSets < ActiveRecord::Migration[8.1]
  def change
    create_table :weight_sets do |t|
      t.integer :reps
      t.decimal :weight
      t.timestamps
      t.references :workout_exercise, null: false, foreign_key: true
    end
  end
end
