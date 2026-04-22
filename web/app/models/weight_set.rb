class WeightSet < ApplicationRecord
  belongs_to :workout_exercise

  validates :reps, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :weight, presence: true, numericality: { greater_than_or_equal_to: 0 }

  validate :exercise_must_be_weights

  private

  def exercise_must_be_weights
    return unless workout_exercise

    errors.add(:base, 'can only be added to a weights exercise') unless workout_exercise.exercise.weights?
  end
end
