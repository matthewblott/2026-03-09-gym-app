class CardioSet < ApplicationRecord
  belongs_to :exercise

  validates :distance, presence: true, numericality: { greater_than: 0 }

  validates :duration_seconds,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }

  validate :exercise_must_be_cardio

  def duration
    return if duration_seconds.nil?

    h = duration_seconds / 3600
    m = (duration_seconds % 3600) / 60
    s = duration_seconds % 60

    format("%02d:%02d:%02d", h, m, s)
  end

  def duration=(value)
    return if value.blank?

    h, m, s = value.split(":").map(&:to_i)
    self.duration_seconds = h * 3600 + m * 60 + s
  end

  private

  def duration_format
    return if duration.blank?

    unless duration.match?(/\A\d{2}:\d{2}:\d{2}\z/)
      errors.add(:duration, "must be HH:MM:SS")
    end
  end

  def exercise_must_be_cardio
    return unless exercise
    errors.add(:base, "can only be added to a cardio exercise") unless exercise.cardio?
  end

end
