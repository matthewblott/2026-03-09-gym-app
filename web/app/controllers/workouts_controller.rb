class WorkoutsController < ApplicationController
  before_action :set_workout, only: %i[ destroy ]

  def index
    @workouts = Workout.order(created_at: :desc)
  end

  def new
    @workout = Workout.new(created_at: Time.current)
  end

  def create
    @workout = Workout.new(workout_params)
    if @workout.save
      redirect_to exercises_path(Current.user, workout_id: @workout.id) 
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @workout.destroy
    redirect_to workouts_path(Current.user)
  end

  private

    def set_workout
      @workout = Workout.find(params.expect(:id))
    end

    def workout_params
      params.expect(workout: [ :created_at ])
    end

end
