# Rails Routing Rules

## Philosophy

Routes must be **explicit, readable, and predictable**.

Avoid Rails routing DSL features that hide the actual routes being created.

Every route should clearly show:

* HTTP verb
* URL path
* controller action
* named route helper

Explicit routing is preferred over Rails meta-programming.

---

## Core Principles

### 1. Do NOT use `resources`

Avoid the Rails `resources` DSL.

While convenient, it hides:

* which routes are created
* how helpers are named
* which HTTP verbs are used

All routes must be defined explicitly.

---

### 2. Do NOT use scope prefixes (`as:`)

Avoid using `as:` on `scope` (e.g. `as: :user`).

Reasons:

* It introduces hidden naming behaviour
* It makes route helpers less predictable
* It can lead to duplication (`user_user_*`)
* It adds no value in tenant-isolated applications

#### Bad ❌

```ruby
scope "/:user_id", as: :user do
```

#### Good ✅

```ruby
scope "/:user_id" do
```

---

### 3. Route helpers must be unique

Each `as:` value must be unique within a scope.

You **cannot** reuse the same helper name across different HTTP verbs.

#### Bad ❌

```ruby
get    "todos/:id", action: :show,   as: :todo
patch  "todos/:id", action: :update, as: :todo
delete "todos/:id", action: :destroy,as: :todo
```

This will raise an error.

---

### 4. Use explicit, semantic helper names

Prefer clear, intention-revealing helper names:

```ruby
todos_path
create_todo_path
destroy_todos_path

todo_path
update_todo_path
destroy_todo_path
```

Helpers should reflect:

* the resource (`todo`, `todos`)
* the action where necessary (`create`, `update`, `destroy`)

---

### 5. Pattern for resource-style routing (without `resources`)

Use this structure consistently:

```ruby
scope "/:user_id", constraints: { user_id: /\d+/ } do
  controller :todos do
    # Collection
    get    "todos", action: :index,  as: :todos
    post   "todos", action: :create, as: :create_todo
    delete "todos", action: :destroy_multiple, as: :destroy_todos

    # Member
    get    "todos/:id", action: :show,    as: :todo
    patch  "todos/:id", action: :update,  as: :update_todo
    delete "todos/:id", action: :destroy, as: :destroy_todo
  end

  controller :settings do
    get "settings", action: :show, as: :settings
  end
end
```

---

## Resulting Route Helpers

```ruby
todos_path
create_todo_path
destroy_todos_path

todo_path
update_todo_path
destroy_todo_path

settings_path
```

---

## Key Takeaways

* Route helpers must be **globally unique per scope**
* Rails does **not** allow sharing helpers across HTTP verbs
* Avoid `scope as:` to keep naming simple and predictable
* Fully explicit routing requires **intentional naming**
* Prefer clarity over strict REST conventions

---

## Optional: When to break these rules

You may deviate if:

* You are building a public API with strict naming requirements
* You need non-RESTful behaviour
* You are introducing your own routing abstraction layer

Otherwise, follow these conventions consistently.

