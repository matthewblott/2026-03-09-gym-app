Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  scope "/:user_id", constraints: { user_id: /\d+/ }, as: :user do
    controller :home do
      get '', action: :index, as: :home
    end

    # controller :notes do
    #   get    'notes',          action: :index,            as: :notes
    #   get    'notes/new',      action: :new,              as: :new_note
    #   post   'notes',          action: :create,           as: :notes_create
    #   delete 'notes',          action: :destroy_multiple, as: :notes_destroy_multiple
    #   get    'notes/:id',      action: :edit,             as: :note
    # end

    controller :account do
      get    'account',           action: :index,            as: :account
      get    'account/new',       action: :new,              as: :new_account
      post   'account/send-code', action: :send_code,        as: :account_send_code
      get    'account/verify',    action: :verify,           as: :account_verify
      post   'account/verify',    action: :verify_code,      as: :account_verify_code
      get    'account/sign-out',  action: :confirm_sign_out, as: :confirm_account_sign_out
      delete 'account/sign-out',  action: :sign_out,         as: :account_sign_out
      get    'account/delete',    action: :confirm_delete,   as: :confirm_account_delete
      delete 'account',           action: :destroy,          as: :account_destroy
    end

    controller :uploads do
      get 'uploads/:filename.png', action: :show, as: :upload
    end

    controller :workouts do
      get    'workouts',          action: :index,   as: :workouts
      post   'workouts',          action: :create,  as: :create_workout
      patch  'workouts/:id',      action: :update,  as: :update_workout
      # delete 'workouts/:id',      action: :destroy, as: :destroy_workout
      delete 'workouts',          action: :destroy_multiple, as: :workouts_destroy_multiple
      # get    'workouts/:id',      action: :edit,             as: :workout
    end

    controller :workout_exercises do
      get    'workout-exercises',           action: :index,   as: :workout_exercises
      get    'workout-exercises/new',       action: :new,     as: :new_workout_exercise
      post   'workout-exercises',           action: :create,  as: :create_workout_exercise
      delete 'workout-exercises/:id',       action: :destroy, as: :destroy_workout_exercise
    end

    controller :sets do
      get    'workout-exercises/:exercise_id/sets',       action: :index,   as: :sets
      get    'workout-exercises/:exercise_id/sets/new',   action: :new,     as: :new_set
      post   'workout-exercises/:exercise_id/sets',       action: :create,  as: :create_set
      delete 'workout-exercises/:exercise_id/sets/:id',   action: :destroy, as: :destroy_set
    end

  end

  # Needs to be moved under user_id scope
  controller :settings do
    get  'settings',        action: :index
  end


  controller :auth do
    get  'auth',            action: :index,     as: :auth
    get  'auth/new',        action: :new,       as: :new_auth
    post 'auth/send',       action: :send_code, as: :auth_send_code
    get  'auth/verify',     action: :verify,    as: :auth_verify_code
    post 'auth/verify',     action: :create,    as: :auth_create
  end

  controller :guest_sessions do
    post   'session/guest',  action: :create,   as: :guest_session_create
  end

  controller :static_pages do
    get 'index',   action: :index
    get 'info',    action: :info
    get 'support', action: :support
    get 'terms',   action: :terms
    get 'privacy', action: :privacy
  end

  root 'static_pages#splash'

end
