# AGENTS.md - Guidelines for AI Coding Assistants

## Project Overview

Rails 8.1.2 gym/workout tracking app with multi-tenancy. Located in `/Users/Matt/Development/2026-03-09-gym-app/web/`.

**Key Technologies:**
- Ruby 4.0.2, Rails 8.1.2
- SQLite3 with multi-database setup (auth + tenant databases)
- ros-apartment for multi-tenancy (URL path-based tenant switching)
- rotp for OTP authentication
- Propshaft asset pipeline
- Hotwire/Stimulus for frontend interactions
- No npm/build tools required

## Build/Development Commands

```bash
# Setup (idempotent - installs deps, prepares DB, clears logs, starts server)
cd web && bin/setup

# Start development server
cd web && bin/dev

# CI (uses ActiveSupport::ContinuousIntegration)
cd web && bin/ci

# Database operations
cd web && bin/rails db:prepare
cd web && bin/rails db:migrate
cd web && bin/rails db:reset

# Console and generators
cd web && bin/rails console
cd web && bin/rails generate
```

**Note:** No testing framework is currently configured (test_unit railtie is disabled in `config/application.rb`). No linting tools (RuboCop, ESLint, etc.) are configured. No npm or frontend build tools are required.

## Code Style Guidelines

### Ruby/Rails

- **Indentation:** 2 spaces, no tabs
- **Follow Rails 8 conventions**
- **Application namespace:** `Todos` (defined in `config/application.rb`)
- **No Rails tag helpers:** Use plain HTML elements instead of `tag.div`, `content_tag`, etc.
- **Current attributes pattern:** Used for request-scoped data (see `app/models/current.rb`)

### HTML/Views

- **Semantic HTML:** Use `<header>`, `<main>`, `<section>`, `<article>`, `<nav>`, etc.
- **Avoid `<div>`:** Create custom elements instead (e.g., `<menu-item>` not `<div class="menu-item">`)
- **Web-component-friendly names:** Favor `<card-header>` style naming
- **Don't over-create elements:** Use `<header>` over `<card-header>` when semantic element exists
- **Use attributes:** Prefer `role="button"` over classes for styling hooks
- **Forms:** Use plain HTML forms with `form_authenticity_token` (not Rails form helpers)

Example:
```erb
<% content_for :title, "Sign in" %>
<form action="<%= session_send_code_path %>" method="post">
  <input type="hidden" name="authenticity_token" value="<%= form_authenticity_token %>">
  <input type="email" name="email" placeholder="alice@example.com" required>
  <button>send otp</button>
</form>
```

### CSS

- **Vanilla CSS only:** No frameworks (Bootstrap, Tailwind, etc.)
- **Fluid design:** Follow patterns from [Utopia](https://utopia.fyi) for responsive spacing/typography
- **Units:** Use `rem` for measurements
- **Nesting:** Use CSS nesting where appropriate
- **Minimal classes:** Style elements directly (e.g., `button { }` not `.button { }`)
- **Minimal variables:** Keep CSS custom properties count low
- **Separation:** Use separate files for layout vs. component styles

### Multi-Tenancy Architecture

**Two database configurations:**
- `primary`: Tenant-specific data (workouts, exercises, sets, todos)
- `auth`: Shared authentication data (users, sessions)

**Migration paths:**
- `db/migrate/tenant/` - Tenant-specific migrations
- `db/migrate/auth/` - Auth database migrations

**Key models:**
- `AuthRecord` - Base for auth database models (users, sessions)
- `ApplicationRecord` - Base for tenant-specific models (workouts, exercises, sets, todos)

**Tenant switching:** Happens automatically via `ApartmentPathTenant` middleware based on URL first segment (numeric user IDs like `/123/workouts`).

### Naming Conventions

- **Controllers:** Plural (e.g., `SessionsController`, `WorkoutsController`)
- **Models:** Singular (e.g., `User`, `Workout`, `Exercise`)
- **Database tables:** Plural snake_case
- **Custom elements:** kebab-case (e.g., `<workout-card>`, `<exercise-form>`)

### Authentication Patterns

- **Guest users:** Device-tied sessions with `device_token`
- **OTP users:** Email-based with `otp_enabled`, `otp_secret` fields
- **Current user/session:** Access via `Current.user`, `Current.session`
- **Session cookie:** Signed cookie named `:session_token`

### Error Handling

- Use `flash.now[:alert]` for render responses
- Use `flash[:notice]` for redirect responses
- Return appropriate HTTP status codes (e.g., `status: :unprocessable_entity`)

## Project Structure

```
web/
├── app/
│   ├── assets/stylesheets/     # Vanilla CSS (site.css, claude_site.css)
│   ├── controllers/            # Rails controllers
│   ├── helpers/                # View helpers
│   ├── models/                 # AuthRecord, ApplicationRecord subclasses
│   ├── views/                  # ERB templates (plain HTML forms)
│   └── mailers/                # OTP mailer
├── config/
│   ├── database.yml            # Multi-database config
│   └── ci.rb                   # CI configuration
├── db/
│   ├── migrate/tenant/         # Tenant-specific migrations
│   └── migrate/auth/           # Auth database migrations
├── bin/                        # Rails executables (setup, dev, ci)
└── instructions/               # Project documentation
    ├── code-guide.md
    ├── project-brief.md
    └── style-guide.md
```

## Key Files to Reference

- `config/application.rb` - Rails config, middleware, tenant switching logic
- `app/models/auth_record.rb` & `app/models/application_record.rb` - Database connection bases
- `app/models/current.rb` - Request-scoped attributes
- `instructions/` - Detailed project guidelines

## Development Notes

- Always run commands from `web/` directory
- Guest account data is deleted on sign out (tenant dropped)
- No JavaScript bundler configured - use vanilla JS or Stimulus
- Propshaft handles asset pipeline (no Sprockets)
- Ignore `claude-files/` folder - it contains alternative view templates and CSS
- Do not use npm or other frontend build tools - they are not required
