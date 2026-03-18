class ExercisesController < ApplicationController
  before_action :set_exercise, only: %i[ show destroy ]

  def show
  end

  def create
    @workout = Workout.find(params[:workout_id])
    @exercise = @workout.exercises.new(exercise_params)
    if @exercise.save
      redirect_to workout_path(Current.user, @workout)
    else
      redirect_to workout_path(Current.user, @workout), status: :unprocessable_entity
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
      params.expect(exercise: [ :name ])
    end

end
