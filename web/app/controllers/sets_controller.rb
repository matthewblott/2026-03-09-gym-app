class SetsController < ApplicationController
  before_action :set_workout_exercise

  def index
    @workout_exercise = WorkoutExercise.find(params[:exercise_id])
    @sets = @workout_exercise.sets
  end

  def create
    @set = build_set

    if @set.save
      if @workout_exercise.weights?
        redirect_to sets_path(Current.user, @workout_exercise)
      else
        redirect_to workout_exercises_path(Current.user, workout_id: @workout_exercise.workout_id)
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_workout_exercise
    @workout_exercise = WorkoutExercise.find(params[:exercise_id])
  end

  def build_set
    if @workout_exercise.weights?
      @workout_exercise.weight_sets.build(weight_set_params)
    else
      @workout_exercise.cardio_sets.build(cardio_set_params)
    end
  end

  def weight_set_params
    params.require(:weight_set).permit(:reps, :weight)
  end

  def cardio_set_params
    params.require(:cardio_set).permit(:duration, :distance)
  end
end
