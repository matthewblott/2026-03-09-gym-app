class CreateExercises < ActiveRecord::Migration[8.1]
  def change
    create_table :exercises do |t|
      t.string :name
      t.string :exercise_type, null: false, default: "weights"
      t.timestamps
    end
  end
end
