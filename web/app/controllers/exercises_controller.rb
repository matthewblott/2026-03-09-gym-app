class ExercisesController < ApplicationController
  before_action :set_exercise, only: %i[ destroy ]

  def index
    @workout_id = params[:workout_id]
    @exercises = Exercise.with_averages.where(workout_id: @workout_id)
  end

  def new
    @workout_id = params[:workout_id]
    @exercise = Exercise.new 
  end

  def show
  end

  def create
    @exercise = Exercise.new(exercise_params)

    if @exercise.save

      if @exercise.weights?
        redirect_to sets_path(Current.user, @exercise)
      else
        redirect_to new_set_path(Current.user, @exercise)
      end

    else
      redirect_to exercises_path(Current.user, workout_id: @workout_id), status: :unprocessable_entity
    end
  end

  def destroy
    @exercise = Exercise.find(params[:id])
    @workout = @exercise.workout
    @exercise.destroy
    redirect_to workout_path(Current.user, @workout)
  end

  private

    def set_exercise
      @exercise = Exercise.find(params.expect(:id))
    end

    def exercise_params
      params.expect(exercise: [ :name, :exercise_type, :workout_id ])
    end

end
