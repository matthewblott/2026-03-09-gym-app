class ExercisesController < ApplicationController
  before_action :set_exercise, only: %i[destroy]

  def index
    @exercises = Exercise.with_averages
  end

  def new
    @workout_id = params[:workout_id]
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(exercise_params)

    if @exercise.save
      if @workout_id = params[:workout_id]
        Workout.find(@workout_id).exercises << @exercise
        redirect_to workout_path(Current.user, @workout_id)
      elsif @exercise.weights?
        redirect_to sets_path(Current.user, @exercise)
      else
        redirect_to new_set_path(Current.user, @exercise)
      end
    else
      redirect_to exercises_path(Current.user), status: :unprocessable_entity
    end
  end

  def destroy
    @exercise = Exercise.find(params[:id])
    @exercise.destroy
    redirect_to exercises_path(Current.user)
  end

  private

  def set_exercise
    @exercise = Exercise.find(params.expect(:id))
  end

  def exercise_params
    params.expect(exercise: %i[name exercise_type])
  end
end
