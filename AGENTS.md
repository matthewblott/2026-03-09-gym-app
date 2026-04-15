# Gym App

The Rails application lives in `web/`. All development commands must run from that directory.

## Quick Start

```
cd web
./bin/setup
```

## Development

- Start server: `./bin/dev` (from web/)
- Run CI: `./bin/ci` (from web/)
- Setup: `./bin/setup --skip-server` (from web/)
- Reset DB: `./bin/setup --reset` (from web/)

## Database

Multi-tenant setup with two SQLite databases:
- `web/storage/<env>/tenant.sqlite3` — per-user workouts, exercises, sets
- `web/storage/<env>/auth.sqlite3` — users, sessions

Run migrations:
```
cd web && bin/rails db:migrate:primary   # tenant schema
cd web && bin/rails db:migrate:auth      # auth schema
```

Create auth migration: `cd web && rails generate migration CreateFoo --database=auth`

## Architecture

- Routes scoped under `/:user_id` — tenant switching is automatic via `ApartmentPathTenant` middleware
- `AuthRecord` — base class for auth models (connects to auth database)
- `ApplicationRecord` — base class for tenant models (connects to current tenant)
- Tenants created when User is created, dropped when guest signs out
- OTP authentication via ROTP gem for email login

## Full Details

See `web/AGENTS.md` for complete implementation details.