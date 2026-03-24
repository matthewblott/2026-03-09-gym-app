# Coding Rules

## Philosophy

Code must be:

- explicit
- minimal
- readable
- predictable

Avoid:

- magic
- metaprogramming
- hidden behaviour
- unnecessary abstraction

If unsure, choose the simplest possible implementation.

---

# Context Priority

All generated code MUST follow rules defined in:

- context/html.md
- context/css.md
- context/erb.md
- context/routes.md

These override default Rails conventions.

## Conflict Resolution

If there is a conflict:

1. Context files take precedence
2. coding-rules.md comes next
3. Rails conventions are last

---

# Rule Enforcement

If a request would violate any context rule:

- DO NOT proceed silently
- Explain the conflict clearly
- Ask for clarification before continuing

---

# Rails Rules

## Routing

- DO NOT use `resources`
- ALWAYS define routes explicitly

Each route must include:

- HTTP verb
- full path
- controller#action
- named route helper

Example:

get "/:user_id/todos", to: "todos#index", as: :todos

Rules:

- Route params must be explicit (e.g. user_id)
- Avoid concerns, scopes, and abstractions
- Do not rely on Rails route helpers implicitly

---

## Controllers

- Controllers must be thin
- Only handle:
  - params
  - rendering
  - redirecting

Do NOT:

- include business logic
- introduce unnecessary methods

---

## Models

- Keep models simple
- Add validations only when requested
- Avoid callbacks unless explicitly requested
- Do not introduce complex logic

---

## Views

- Follow context/html.md and context/erb.md
- Use semantic HTML
- Avoid unnecessary wrappers and attributes
- Keep ERB minimal and readable

---

## CSS

- Follow context/css.md
- Avoid class-heavy styling unless explicitly required
- Prefer semantic structure over styling hacks

---

# File Changes (CRITICAL)

- NEVER modify files directly
- NEVER write outside tmp/
- ALWAYS write to tmp/ first

## Path Rules

Mirror the real structure inside tmp/

Examples:

app/models/todo.rb → tmp/app/models/todo.rb  
app/controllers/todos_controller.rb → tmp/app/controllers/todos_controller.rb  

---

# Modifications

- ALWAYS output FULL file contents
- NEVER output diffs or partial snippets
- Preserve existing code unless a change is required

---

# Output Requirements

For every generated file:

1. Show the full file path (tmp/...)
2. Show complete file contents
3. Use a code block with appropriate language

---

# Naming

- Use clear, explicit names
- Avoid abbreviations
- Avoid unnecessary prefixes/suffixes

---

# Tests

- Tests must be:
  - minimal
  - focused
  - readable

Rules:

- Test only what was requested
- Do not over-test
- Do not introduce complex setups
- Do not modify application code

---

# Defaults

If not explicitly requested:

- Do NOT add extra features
- Do NOT refactor unrelated code
- Do NOT introduce new patterns
- Do NOT guess intent
