class SetsController < ApplicationController

  def index
    @workout_exercise = WorkoutExercise.find(params[:workout_exercise_id])

    if @workout_exercise.exercise.weights?
      @sets = WeightSet.where(workout_exercise_id: @workout_exercise.id) 
    else
      @sets = CardioSet.where(workout_exercise_id: @workout_exercise.id) 
    end
  end

  def new
    @workout_exercise = WorkoutExercise.find(params[:workout_exercise_id])
  end

  def create
    @workout_exercise = WorkoutExercise.find(params[:workout_exercise_id])
    @set = build_set

    if @set.save
      redirect_to user_sets_path(Current.user, workout_exercise_id: @workout_exercise)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_workout_exercise
    @workout_exercise = WorkoutExercise.find(params[:workout_exercise_id])
  end

  def build_set
    if @workout_exercise.exercise.weights?
      WeightSet.new(weight_set_params)
    else
      set = CardioSet.new(cardio_set_params)
      set.duration = "#{set.hours}:#{set.minutes}:#{set.seconds}"
      set
    end
  end

  def weight_set_params
    params.require(:weight_set).permit(:workout_exercise_id, :reps, :weight)
  end

  def cardio_set_params
    params.require(:cardio_set).permit(:workout_exercise_id, :hours, :minutes, :seconds, :distance)
  end
end
