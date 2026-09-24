class CardioSet < ApplicationRecord
  belongs_to :workout_exercise

  validates :distance, presence: true, numericality: { greater_than: 0 }
  validates :duration, presence: true

  attr_accessor :hours
  attr_accessor :minutes
  attr_accessor :seconds

end
