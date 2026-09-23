class WorkoutExercise < ApplicationRecord
  belongs_to :workout
  belongs_to :exercise

  has_many :weight_sets, dependent: :destroy
  has_many :cardio_sets, dependent: :destroy

  # validates :exercise_id, uniqueness: { scope: :workout_id, message: "is already in this workout" }

  attr_accessor :name
  attr_accessor :exercise_type

  # enum :exercise_type, { weights: 'weights', cardio: 'cardio' }
  #
  # validates :name, presence: true
  # validates :exercise_type, presence: true
  #
  # def sets
  #   weights? ? weight_sets : cardio_sets
  # end

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
end
