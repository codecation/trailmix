# Trailmix

A private journaling app that sends daily email prompts and creates entries from replies.

## Tech Stack

- Ruby 3.4.2 (managed with mise)
- Rails 8.0
- PostgreSQL
- Sidekiq (background jobs)
- RSpec (testing)

## Commands

```bash
# Setup
./bin/setup

# Run server
foreman start

# Run all tests (copy .env.sample to .env first)
cp .env.sample .env  # if not already done
mise exec -- bundle exec rspec

# Run specific test file
bundle exec rspec spec/path/to/file_spec.rb

# Database
bundle exec rake db:migrate
bundle exec rake dev:prime  # seed development data

# Rails console
bundle exec rails console
```

## Project Structure

- `app/` - Rails application code (models, views, controllers, mailers)
- `spec/` - RSpec tests
- `config/` - Rails configuration
- `db/` - Database migrations and schema
- `lib/tasks/` - Custom Rake tasks

## Testing

Uses RSpec with FactoryBot for fixtures. Tests are in `spec/` mirroring `app/` structure.

## Code Style

Follows [thoughtbot guides](https://github.com/thoughtbot/guides) for style and best practices.

## Deployment

Production is deployed to Heroku: `https://git.heroku.com/trailmix-production.git`
