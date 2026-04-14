# Agent Guidelines for Gym App

## 🚀 Quick Start

**Start the dev server:** `./bin/dev` (or `bundle exec rails server`)

**Run setup:** `./bin/setup` (installs dependencies, prepares database, starts server)

**Run CI:** `./bin/ci` (runs setup with `--skip-server` flag)

## 📋 Database Architecture

This is a **multi-tenant Rails application** using the Apartment gem with separate databases:

### Primary Database (`primary`)
- Stores per-tenant application data: workouts, exercises, weight_sets, cardio_sets
- Located at: `storage/&lt;Rails.env&gt;/tenant.sqlite3`
- Migrations path: `db/migrate/tenant`
- Run: `rails db:migrate:primary`

### Auth Database (`auth`)
- Stores shared authentication data: users, sessions
- Located at: `storage/&lt;Rails.env&gt;/auth.sqlite3`
- Migrations path: `db/migrate/auth`
- Run: `rails db:migrate:auth`
- Create auth migrations: `rails generate migration CreateFoo --database=auth`

Tenants are created/dropped automatically:
- Created when a User is created: `Apartment::Tenant.create(id.to_s)`
- Dropped when guest users sign out: `Apartment::Tenant.drop(Current.user.id.to_s)`

**Models inherit from:**
- `AuthRecord` for auth models (connects to `auth` database)
- `ApplicationRecord` for tenant models (connects to current tenant database)

## 🔧 Development Commands

### Database
- `./bin/rails db:prepare` - Setup both databases
- `./bin/rails db:migrate:primary` - Migrate tenant database
- `./bin/rails db:migrate:auth` - Migrate auth database  
- `./bin/rails db:reset` - Reset both databases (used with `--reset` flag in setup)

### Multi-tenancy
- Tenant switching is automatic via path segments: `/:user_id/workouts`
- Uses `ApartmentPathTenant` middleware to switch based on numeric URL segment
- Routes are scoped under `/:user_id` for tenant isolation

## 📁 Key Directories

### `app/models/`
- `AuthRecord.rb` - Base class for auth models (database: auth)
- `ApplicationRecord.rb` - Base class for tenant models  
- `Current.rb` - Store current user/session context
- `User.rb`, `Session.rb` - Auth models
- `Workout.rb`, `Exercise.rb`, `WeightSet.rb`, `CardioSet.rb` - Tenant models

### `config/`
- `database.yml` - Multi-database configuration
- `routes.rb` - Scoped routes with `/:user_id` pattern
- `application.rb` - Apartment middleware setup

## ⚠️ Important Notes

1. **Tenant Scope**: All tenant routes require `/:user_id` prefix
2. **Auth vs Tenant**: Auth models use `AuthRecord`, tenant models use `ApplicationRecord`
3. **Guest Users**: Guest accounts create tenants that are destroyed on sign-out
4. **OTP Authentication**: Email login uses one-time passwords (OTP) via ROTP gem
5. **No Testing**: No test suite configured (test agent disabled in opencode.jsonc)
6. **Ruby Version**: Ruby 4.0.2 (specified in .ruby-version)

## 🛠️ Tooling

- **Hotwire-LiveReload**: Development live reload
- **Propshaft**: Asset pipeline (Rails default)
- **Puma**: Web server
- **SQLite3**: Database