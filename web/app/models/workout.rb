class Workout < ApplicationRecord
  has_many :workout_exercises, dependent: :destroy

  validates :created_at, presence: true
end
