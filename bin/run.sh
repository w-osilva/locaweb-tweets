#!/bin/bash

RAILS_PORT=3000

# Remove pids
/bin/rm -f /app/tmp/pids/server.pid \
           /app/tmp/pids/puma.pid

# Initialize Ruby on Rails
exec /app/bin/rails server -b 0.0.0.0 -p ${RAILS_PORT}