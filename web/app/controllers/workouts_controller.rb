class WorkoutsController < ApplicationController
  include Pagy::Method
  before_action :set_workout, only: %i[destroy]

  def index
    @pagy, @workouts = pagy(Workout.recent_first, items: 20)
  end

  def new
    @workout = Workout.new(created_at: Time.current)
  end

  def create
    @workout = Workout.new(workout_params)
    if @workout.save
      redirect_to user_new_workout_exercise_path(Current.user, workout_id: @workout.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @workout.destroy
    redirect_to user_workouts_path(Current.user)
  end

  def destroy_multiple
    @deleted_ids = Array(params[:ids])
    Workout.where(id: params[:ids]).destroy_all
  end

  private

  def set_workout
    @workout = Workout.find(params.expect(:id))
  end

  def workout_params
    params.expect(workout: [:created_at])
  end
end
