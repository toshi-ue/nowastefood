#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /webapp/tmp/pids/server.pid

if [ ! -e "/webapp/tmp" ]; then
  sudo mkdir /webapp/tmp
fi

if [ ! -e "/webapp/tmp/pids" ]; then
  sudo mkdir /webapp/tmp/pids
fi

if [ ! -e "/webapp/tmp/sockets" ]; then
  sudo mkdir /webapp/tmp/sockets
fi

if [ ! -e "${RAILS_ENV}" = "production" ]; then
  bundle exec rails webpacker:install
  bundle exec rails webpacker:compile
  bundle exec rails assets:precompile
  bundle exec bin/webpack
fi
# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
