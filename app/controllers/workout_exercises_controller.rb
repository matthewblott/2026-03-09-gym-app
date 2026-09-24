class WorkoutExercisesController < ApplicationController
  before_action :set_workout_exercise, only: %i[destroy]

  def index
    @workout_id = params[:workout_id]
    @workout_exercises = WorkoutExercise.where(workout_id: @workout_id)
  end

  def new
    @workout_id = params[:workout_id]
    @workout_exercise = WorkoutExercise.new
  end

  def create
    @workout_exercise = WorkoutExercise.new(workout_exercise_params)
    
    exercise =
      if @workout_exercise.exercise_id.present?
        Exercise.find(@workout_exercise.exercise_id)
      else
        Exercise.create(name: @workout_exercise.name, exercise_type: @workout_exercise.exercise_type)
      end

    @workout_exercise.exercise_id = exercise.id
    
    if @workout_exercise.save
      redirect_to user_new_set_path(Current.user, workout_exercise_id: @workout_exercise)
    else
      redirect_to user_workout_exercises_path(Current.user, workout_id: @workout_id), status: :unprocessable_entity
    end

  end

  def destroy
    @workout_exercise = WorkoutExercise.find(params[:id])
    @workout = @workout_exercise.workout
    @workout_exercise.destroy
    redirect_to user_workout_path(Current.user, @workout)
  end

  private

  def set_workout_exercise
    @workout_exercise = WorkoutExercise.find(params.expect(:id))
  end

  def workout_exercise_params
    params.expect(workout_exercise: %i[name exercise_type exercise_id workout_id])
  end
end
