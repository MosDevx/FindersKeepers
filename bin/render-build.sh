#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install

bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec sidekiq 
# bundle exec rails db:create RAILS_ENV=production  # Create the database
# bundle exec rails db:migrate RAILS_ENV=production # Run migrations
# bundle exec rails db:seed RAILS_ENV=production    # Seed the database (optional)
