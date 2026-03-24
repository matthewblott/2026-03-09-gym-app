class CardioSet < ApplicationRecord
  belongs_to :exercise

  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :distance, presence: true, numericality: { greater_than: 0 }
  validate :exercise_must_be_cardio

  private

  def exercise_must_be_cardio
    return unless exercise
    errors.add(:base, "can only be added to a cardio exercise") unless exercise.cardio?
  end

  def duration_in_minutes
    duration / 60
  end

end
