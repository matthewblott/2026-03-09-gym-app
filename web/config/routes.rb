Rails.application.routes.draw do
  controller :registrations do
    get  'register',        action: :new,       as: :registration
    post 'register/send',   action: :send_code, as: :registration_send_code
    get  'register/verify', action: :verify,    as: :registration_verify_code
    post 'register/verify', action: :create,    as: :registration_create
  end

  controller :guest_sessions do
    post 'session/guest', action: :create, as: :guest_session_create
  end

  controller :user_security do
    get  'security',        action: :new,       as: :security
    post 'security/send',   action: :send_code, as: :security_send_code
    get  'security/verify', action: :verify,    as: :security_verify_code
    post 'security/verify', action: :create,    as: :security_create
  end

  controller :sessions do
    get  'session',            action: :new,       as: :session
    post 'session/send',       action: :send_code, as: :session_send_code
    get  'session/verify',     action: :verify,    as: :session_verify_code
    post 'session/verify',     action: :create,    as: :session_create
    delete 'session/sign_out', action: :destroy,   as: :session_destroy
  end

  scope '/:user_id', constraints: { user_id: /\d+/ } do
    controller :workouts do
      get    'workouts',          action: :index,   as: :workouts
      post   'workouts',          action: :create,  as: :create_workout
      patch  'workouts/:id',      action: :update,  as: :update_workout
      delete 'workouts/:id',      action: :destroy, as: :destroy_workout
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

  controller :settings do
    get  'settings',        action: :index
    get  'settings/send',   action: :email,     as: :settings_email
    post 'settings/send',   action: :send_code, as: :settings_send_code
    get  'settings/verify', action: :verify,    as: :settings_verify_code
    post 'settings/verify', action: :create,    as: :settings_create
  end

  controller :static_pages do
    get 'about', action: :about
  end

  root 'static_pages#home'
end
