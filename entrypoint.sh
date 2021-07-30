#!/bin/bash
set -e

# サーバーが起動するたびに実行したいことを書く
echo "start bundle install!!"
bundle install
echo "end   bundle install!!"

echo "start migration!!"
bundle exec rake db:migrate
echo "end   migration!!"

# Remove a potentially pre-existing server.pid for Rails.
rm -f /music-server/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
