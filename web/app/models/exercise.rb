class Exercise < ApplicationRecord
  # belongs_to :workout
  # has_many :weight_sets, dependent: :destroy
  # has_many :cardio_sets, dependent: :destroy
  #
  # enum :exercise_type, { weights: 'weights', cardio: 'cardio' }
  #
  # validates :name, presence: true
  # validates :exercise_type, presence: true
  #
  # def sets
  #   weights? ? weight_sets : cardio_sets
  # end
  #
  # scope :with_averages, lambda {
  #   exercises   = arel_table
  #   weight_sets = WeightSet.arel_table
  #
  #   avg_reps   = weight_sets[:reps].average.as('avg_reps')
  #   avg_weight = weight_sets[:weight].average.as('avg_weight')
  #
  #   left_joins(:weight_sets)
  #     .select(exercises[Arel.star], avg_reps, avg_weight)
  #     .group(exercises[:id])
  # }

  has_many :workout_exercises, dependent: :restrict_with_error

  enum :exercise_type, { weights: "weights", cardio: "cardio" }

  validates :name, presence: true
  validates :exercise_type, presence: true

end
