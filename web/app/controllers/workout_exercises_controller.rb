class WorkoutExercisesController < ApplicationController
  before_action :set_workout_exercise, only: %i[destroy]

  def index
    @workout_id = params[:workout_id]
    @workout_exercises = WorkoutExercise.with_averages.where(workout_id: @workout_id)
  end

  def new
    @workout_id = params[:workout_id]
    @exercises = Exercise.all
  end

  def show; end

  # def create
  #   @workout_exercise = WorkoutExercise.new(workout_exercise_params)
  #
  #   if @workout_exercise.save
  #
  #     if @workout_exercise.exercise.weights?
  #       redirect_to sets_path(Current.user, @workout_exercise)
  #     else
  #       redirect_to new_set_path(Current.user, @workout_exercise)
  #     end
  #
  #     redirect_to workout_exercises_path(Current.user, workout_id: @workout_id)
  #
  #   else
  #     redirect_to workout_exercises_path(Current.user, workout_id: @workout_id), status: :unprocessable_entity
  #   end
  # end


  def create
    @workout = Workout.find(params[:workout_id])
    
    # If creating a new exercise
    if params[:exercise].present?
      exercise = Exercise.find_or_create_by(
        name: params[:exercise][:name],
        exercise_type: params[:exercise][:exercise_type]
      )
      
      if exercise.persisted?
        @workout_exercise = @workout.workout_exercises.build(exercise: exercise)
      else
        # Handle validation errors
        @exercises = Exercise.all
        flash.now[:error] = "Could not create exercise: #{exercise.errors.full_messages.join(', ')}"
        render :new and return
      end
    else
      # Using existing exercise
      @workout_exercise = @workout.workout_exercises.build(workout_exercise_params)
    end
    
    if @workout_exercise.save
      redirect_to workout_path(Current.user, @workout), notice: 'Exercise added successfully'
    else
      @exercises = Exercise.all
      flash.now[:error] = @workout_exercise.errors.full_messages.join(', ')
      render :new
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
    params.expect(workout_exercise: %i[workout_id exercise_id])
  end
end
