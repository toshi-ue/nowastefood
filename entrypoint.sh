#!/bin/bash
set -e

# https://stackoverflow.com/questions/55693329/how-to-run-a-rails-app-in-docker-on-heroku
# Remove a potentially pre-existing server.pid for Rails.
if [ -f "/webapp/tmp/pids/server.pid" ]; then
  rm -f /webapp/tmp/pids/server.pid
fi

if [ ! -e "${RAILS_ENV}" = "production" ]; then
  rm -rf node_modules
  bundle exec rails webpacker:clobber
  bundle exec rails webpacker:install
  bundle exec rails webpacker:compile
  bundle exec rails assets:precompile
  bundle exec bin/webpack
fi

exec "$@"
