class SetsController < ApplicationController
  before_action :set_model, only: %i[ destroy ]

  def create
    @exercise = Exercise.find(params[:exercise_id])
    @workout = @exercise.workout
    @exercise_set = @exercise.exercise_sets.new(set_params)
    if @exercise_set.save
      redirect_to exercise_path(Current.user, @exercise)
    else
      redirect_to exercise_path(Current.user, @exercise), status: :unprocessable_entity
    end
  end

  def destroy
    exercise_id = params[:exercise_id]
    @exercise_set.destroy
    redirect_to exercise_path(Current.user, exercise_id)
  end

  private
    def set_model 
      @exercise_set = ExerciseSet.find_by(:id => params[:id], :exercise_id => params[:exercise_id])
    end

    def set_params
      params.expect(exercise_set: [ :reps, :weight ])
    end
end
