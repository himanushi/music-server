#!/bin/bash
set -e

# サーバーが起動するたびに実行したいことを書く
echo "start migration!!"
bundle exec rake db:migrate
echo "end   migration!!"

echo "start generating sitemap!!"
bundle exec rails runner SitemapGenerator.generate_all
echo "end   generating sitemap!!"

# Remove a potentially pre-existing server.pid for Rails.
rm -f /music-server/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
