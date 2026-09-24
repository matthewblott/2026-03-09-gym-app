class CreateCardioSets < ActiveRecord::Migration[8.1]
  def change
    create_table :cardio_sets do |t|
      t.references :workout_exercise, null: false, foreign_key: true
      t.integer :distance
      t.string :duration, limit: 8
      t.timestamps
    end
  end
end
