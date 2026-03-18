# Repository Map

## Framework
Ruby 4.0.2
Rails 8.1.2

## Project Structure

./web/app/models
ActiveRecord models.

./web/app/controllers
HTTP controllers. Should remain thin.

./web/app/services
Service objects for business logic.

./web/app/jobs
Background jobs.

./web/app/views
Rails views and partials.

./web/app/helpers
View helpers.

./web/lib
Shared utilities and domain logic.

./web/test
Minitest tests.

./web/db/migrate
Database migrations.

---

## Architectural Conventions

Controllers
- should not contain business logic
- delegate to service objects

Models
- use scopes for query helpers
- validations belong here

Services
- one public method: `call`
- instantiated as `Service.new(...).call`

Background Jobs
- inherit from `./web/applicationJob`

---

## Testing

Test framework: Minitest (Rails default)

Common commands:

bin/rails test
