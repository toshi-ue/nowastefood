#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /webapp/tmp/pids/server.pid

if [ ! -e "/webapp/tmp" ]; then
  mkdir /webapp/tmp
fi

if [ ! -e "/webapp/tmp/pids" ]; then
  mkdir /webapp/tmp/pids
fi

if [ ! -e "/webapp/tmp/sockets" ]; then
  mkdir /webapp/tmp/sockets
fi

if [ ! -e "${RAILS_ENV}" = "production" ]; then
  bundle exec rails webpacker:compile
  bundle exec rails assets:precompile
fi
# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
