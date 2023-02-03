#!/bin/bash
set -e

# https://stackoverflow.com/questions/55693329/how-to-run-a-rails-app-in-docker-on-heroku
# Remove a potentially pre-existing server.pid for Rails.
if [ -f "/webapp/tmp/pids/server.pid" ]; then
  rm -f /webapp/tmp/pids/server.pid
fi

if [ ! -e "${RAILS_ENV}" = "production" ]; then
  bundle exec rails webpacker:install
  bundle exec rails webpacker:compile
  # https://railsguides.jp/asset_pipeline.html#%E3%82%A2%E3%82%BB%E3%83%83%E3%83%88%E3%82%92%E3%83%97%E3%83%AA%E3%82%B3%E3%83%B3%E3%83%91%E3%82%A4%E3%83%AB%E3%81%99%E3%82%8B
  bundle exec rails assets:precompile RAILS_ENV=production
  bundle exec bin/webpack
fi

exec "$@"
