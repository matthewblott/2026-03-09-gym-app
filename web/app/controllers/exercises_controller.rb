class ExercisesController < ApplicationController
  before_action :set_exercise, only: %i[destroy]

  def index
    @exercises = Exercise.all
  end

  def new
    @exercise = Exercise.new
  end

  def show; end

  def create
    @exercise = Exercise.new(exercise_params)

    if @exercise.save
      redirect_to exercises_path(Current.user)
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
    params.expect(exercise: %i[name exercise_type ])
  end
end
