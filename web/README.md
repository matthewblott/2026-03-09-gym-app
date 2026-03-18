resources :sessions do
  resources :exercises, shallow: true do
    resources :sets, shallow: true
  end
end
```

---

### 4. Controllers

**`SessionsController`** — standard CRUD. `new` defaults `started_at` to `Time.current`.

**`ExercisesController`** — scoped under a session. After create/destroy, redirect back to the parent session show page.

**`SetsController`** — scoped under an exercise. After create/destroy, redirect back to the grandparent session show page (via `exercise.session`).

---

### 5. Views

**Sessions**
- `index` — list of past sessions with date/time, link to show
- `new` / `edit` — form with a datetime-local input for `started_at`
- `show` — displays session time, lists exercises, each with their sets; includes add-exercise form inline and per-exercise add-set form inline using Turbo Frames

**Exercises**
- No dedicated index (shown within session show)
- `_form` partial — single text input for name, rendered inside a `<turbo-frame>`

**Sets**
- No dedicated index (shown within session show)
- `_form` partial — inputs for reps (integer) and weight (decimal), rendered inside a `<turbo-frame>`

---

### 6. Turbo Frame Structure (on Session#show)
```
session show
 └─ <turbo-frame id="exercises">
     ├─ exercise list (each in <turbo-frame id="exercise_N">)
     │    ├─ sets list
     │    └─ <turbo-frame id="new_set_exercise_N"> ← inline add-set form
     └─ <turbo-frame id="new_exercise"> ← inline add-exercise form
