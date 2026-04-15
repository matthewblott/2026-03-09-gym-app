class WorkoutExercisesController < ApplicationController
  before_action :set_workout_exercise, only: %i[destroy]

  def index
    @workout_id = params[:workout_id]
    @workout_exercises = WorkoutExercise.with_averages.where(workout_id: @workout_id)
  end

  def new
    @workout_id = params[:workout_id]
    @workout_exercise = WorkoutExercise.new
  end

  def show; end

  def create
    @workout_exercise = WorkoutExercise.new(workout_exercise_params)

    if @workout_exercise.save
      if @workout_exercise.weights?
        redirect_to sets_path(Current.user, @workout_exercise)
      else
        redirect_to new_set_path(Current.user, @workout_exercise)
      end
    else
      redirect_to workout_exercises_path(Current.user, workout_id: @workout_id), status: :unprocessable_entity
    end
  end

  def destroy
    @workout_exercise = WorkoutExercise.find(params[:id])
    @workout = @workout_exercise.workout
    @workout_exercise.destroy
    redirect_to workout_path(Current.user, @workout)
  end

  private

  def set_workout_exercise
    @workout_exercise = WorkoutExercise.find(params.expect(:id))
  end

  def workout_exercise_params
    params.expect(workout_exercise: %i[name exercise_type workout_id])
  end
end
