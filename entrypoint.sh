#!/bin/bash
set -e

# remove a potentially pre-existing server.pid for rails.
rm -f /myapp/tmp/server.pid

# DB create
bin/rails db:create

# DB migrate
# when init database ...
# DISABLE_DATABASE_ENVIRONMENT_CHECK=1 rails db:migrate:reset
bin/rails db:migrate

bin/rails db:seed

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
