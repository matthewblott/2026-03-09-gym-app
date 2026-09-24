class Exercise < ApplicationRecord
  has_many :workout_exercises, dependent: :destroy

  scope :name_like, -> (query) { where("name LIKE ?", "%#{query}%") }

  enum :exercise_type, { weights: 'weights', cardio: 'cardio' }

  def weights?
    exercise_type == 'weights'
  end

  def cardio?
    exercise_type == 'cardio'
  end

end

