class Exercise < ApplicationRecord
  belongs_to :workout
  has_many :weight_sets, dependent: :destroy
  has_many :cardio_sets, dependent: :destroy

  enum :exercise_type, { weights: "weights", cardio: "cardio" }

  validates :name, presence: true
  validates :exercise_type, presence: true

  def sets
    weights? ? weight_sets : cardio_sets
  end

end
