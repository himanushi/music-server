#!/bin/bash
set -e

bundle install
bundle exec rails db:migrate

# Remove a potentially pre-existing server.pid for Rails.
rm -f /music-server/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
