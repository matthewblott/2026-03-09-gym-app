class CreateWeightSets < ActiveRecord::Migration[8.1]
  def change
    create_table :weight_sets do |t|
      t.references :exercise, null: false, foreign_key: true
      t.integer :reps
      t.decimal :weight
      t.timestamps
    end
  end
end
