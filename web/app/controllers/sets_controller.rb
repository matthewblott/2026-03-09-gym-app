class SetsController < ApplicationController
  before_action :set_exercise

  def index
    exercise_id = params[:exercise_id] 
    @exercise = Exercise.find(exercise_id)
    @sets = @exercise.sets 
  end

  def create
    @set = build_set

    if @set.save
      if @exercise.weights?
        redirect_to sets_path(Current.user, @exercise)
      else
        redirect_to exercises_path(Current.user, workout_id: @exercise.workout_id) 
      end

    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def set_exercise
      @exercise = Exercise.find(params[:exercise_id])
    end

    def build_set
      if @exercise.weights?
        @exercise.weight_sets.build(weight_set_params)
      else
        @exercise.cardio_sets.build(cardio_set_params)
      end
    end

    def weight_set_params
      params.require(:weight_set).permit(:reps, :weight)
    end

    def cardio_set_params
      params.require(:cardio_set).permit(:duration, :distance)
    end

end
