class ExercisesController < ApplicationController
  before_action :set_exercise, only: %i[edit update destroy]

  def index
    @exercises = Exercise.all
  end

  def new
    @exercise = Exercise.new
  end

  def edit 
  end

  def create
    @exercise = Exercise.new(exercise_params)

    if @exercise.save
      redirect_to user_exercises_path
    else
      redirect_to user_exercises_path, status: :unprocessable_entity
    end
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to user_exercises_path
    else
      redirect_to user_exercises_path, status: :unprocessable_entity
    end
  end

  def destroy
    @exercise = Exercise.find(params[:id])
    @exercise.destroy
    redirect_to user_exercises_path
  end

  def search_test
  end

  def search
    q = params[:q]
    exercises = if q.present?
      Exercise.name_like(q)
    else
      []
    end

    items = {}
    exercises.map { |exercise| items[exercise.id] = exercise }

    respond_to do |format|
      format.turbo_stream do
        render(
          turbo_stream: turbo_stream.update(
            'search_results',
            partial: 'shared/search_results',
            locals: {items: items, q: q}
          )
        )
      end
    end
  end

  private

  def set_exercise
    @exercise = Exercise.find(params.expect(:id))
  end

  def exercise_params
    params.expect(exercise: %i[name exercise_type])
  end
end
