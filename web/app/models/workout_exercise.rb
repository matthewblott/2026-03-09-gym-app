class WorkoutExercise < ApplicationRecord
  belongs_to :workout
  belongs_to :exercise

  has_many :weight_sets, dependent: :destroy
  has_many :cardio_sets, dependent: :destroy

  attr_accessor :q
  attr_accessor :name
  attr_accessor :exercise_type

end
