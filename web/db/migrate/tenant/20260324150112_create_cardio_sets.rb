class CreateCardioSets < ActiveRecord::Migration[8.1]
  def change
    create_table :cardio_sets do |t|
      t.integer :duration_seconds
      t.decimal :distance
      t.timestamps
      t.references :workout_exercise, null: false, foreign_key: true
    end
  end
end
