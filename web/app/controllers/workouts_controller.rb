class WorkoutsController < ApplicationController
  before_action :set_workout, only: %i[show destroy add_exercise remove_exercise exercises]

  def index
    @workouts = Workout.order(created_at: :desc)
  end

  def new
    @workout = Workout.new(created_at: Time.current)
  end

  def create
    @workout = Workout.new(workout_params)
    if @workout.save
      redirect_to workout_path(Current.user, @workout)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @exercises = @workout.exercises
  end

  def exercises
    @exercises = Exercise.with_averages
  end

  def add_exercise
    @workout = Workout.find(params[:workout_id] || params[:id])
    @exercise = Exercise.find(params[:exercise_id])

    if @workout.exercises.exists?(@exercise.id)
      redirect_to workout_path(Current.user, @workout), alert: 'Exercise already added'
    else
      @workout.exercises << @exercise
      redirect_to workout_path(Current.user, @workout)
    end
  end

  def remove_exercise
    @workout.exercises.destroy(params[:exercise_id])
    redirect_to workout_path(Current.user, @workout)
  end

  def destroy
    @workout.destroy
    redirect_to workouts_path(Current.user)
  end

  private

  def set_workout
    @workout = Workout.find(params[:workout_id] || params[:id])
  end

  def workout_params
    params.expect(workout: [:created_at])
  end
end
