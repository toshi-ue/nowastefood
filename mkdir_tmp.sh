#!/bin/sh
set -e

# Remove a potentially pre-existing server.pid for Rails.
if [! -e "/webapp/tmp"]; then
  mkdir /webapp/tmp
fi

if [! -e "/webapp/tmp/sockets"]; then
  mkdir /webapp/tmp/sockets
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
