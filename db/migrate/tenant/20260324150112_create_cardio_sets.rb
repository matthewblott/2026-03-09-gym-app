class CreateCardioSets < ActiveRecord::Migration[8.1]
  def change
    create_table :cardio_sets do |t|
      t.references :exercise, null: false, foreign_key: true
      t.integer :duration_seconds
      t.decimal :distance
      t.timestamps
    end
  end
end
