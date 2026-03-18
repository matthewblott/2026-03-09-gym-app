Rails.application.routes.draw do

  # scope "/:user_id", constraints: { user_id: /\d+/ } do
  #   controller :todos do
  #     # Collection
  #     get    "todos", action: :index,  as: :todos
  #     post   "todos", action: :create, as: :create_todo
  #     delete "todos", action: :destroy_multiple, as: :destroy_todos
  #
  #     # Member
  #     get    "todos/:id", action: :show,    as: :todo
  #     patch  "todos/:id", action: :update,  as: :update_todo
  #     delete "todos/:id", action: :destroy, as: :destroy_todo
  #   end
  # end

  controller :registrations do
    get  "register",        action: :new,       as: :registration
    post "register/send",   action: :send_code, as: :registration_send_code
    get  "register/verify", action: :verify,    as: :registration_verify_code
    post "register/verify", action: :create,    as: :registration_create
  end

  controller :guest_sessions do
    post   "session/guest",  action: :create,   as: :guest_session_create
  end

  controller :user_security do
    get  "security",        action: :new,       as: :security
    post "security/send",   action: :send_code, as: :security_send_code
    get  "security/verify", action: :verify,    as: :security_verify_code
    post "security/verify", action: :create,    as: :security_create
  end

  controller :sessions do
    get  "session",            action: :new,       as: :session
    post "session/send",       action: :send_code, as: :session_send_code
    get  "session/verify",     action: :verify,    as: :session_verify_code
    post "session/verify",     action: :create,    as: :session_create
    delete "session/sign_out", action: :destroy,   as: :session_destroy
  end

  scope "/:user_id", constraints: { user_id: /\d+/ } do
    controller :workouts do
      get    "workouts",          action: :index,   as: :workouts
      get    "workouts/new",      action: :new,     as: :new_workout
      post   "workouts",          action: :create,  as: :create_workout
      get    "workouts/:id",      action: :show,    as: :workout
      get    "workouts/:id/edit", action: :edit,    as: :edit_workout
      patch  "workouts/:id",      action: :update,  as: :update_workout
      delete "workouts/:id",      action: :destroy, as: :destroy_workout
    end

    controller :exercises do
      get    "exercises/:id",         action: :show,    as: :exercise
      post   "workouts/:workout_id/exercises", action: :create,  as: :create_exercise
      delete "exercises/:id",                  action: :destroy, as: :destroy_exercise
    end

    controller :sets do
      post   "exercises/:exercise_id/sets", action: :create,  as: :create_set
      delete "sets/:id",                    action: :destroy, as: :destroy_set
    end
  end

  controller :static_pages do
    get "about", action: :about
  end

  root "static_pages#home"

end
