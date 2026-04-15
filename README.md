# Gym App

A multi-tenant workout tracking application built with Rails.

## Quick Start

```bash
cd web
./bin/setup
./bin/dev
```

## Tech Stack

- **Framework:** Rails with Hotwire (Turbo + Stimulus)
- **Database:** Multi-tenant SQLite (Apartment gem)
  - `auth.sqlite3` — users, sessions
  - `tenant.sqlite3` — workouts, exercises, sets (per-user)
- **Auth:** Email + OTP via ROTP

## Features

- Track workouts, exercises, weight sets, and cardio sessions
- Email authentication with one-time passwords
- Guest mode with data migration on signup

## Development

| Command | Description |
|---------|-------------|
| `./bin/dev` | Start dev server |
| `./bin/ci` | Run CI tests |
| `./bin/setup --skip-server` | Install dependencies |
| `./bin/setup --reset` | Reset databases |

## Architecture

- Routes scoped under `/:user_id` with automatic tenant switching
- `AuthRecord` — base class for auth models
- `ApplicationRecord` — base class for tenant models
- Tenants created on user signup, dropped on guest signout