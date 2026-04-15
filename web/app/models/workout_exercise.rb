class WorkoutExercise < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout

  validates :exercise_id, uniqueness: { scope: :workout_id }
end
