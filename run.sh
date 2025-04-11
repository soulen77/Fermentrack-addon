#!/bin/bash

set -e  # Exit on any error

echo "Starting Fermentrack Add-on..."

# Set Django secret key
export DJANGO_SECRET_KEY="${DJANGO_SECRET_KEY:-default-secret-key}"

# Run database migrations
echo "Running database migrations..."
if ! python3 manage.py migrate; then
    echo "Migration failed. Check the logs for details."
    exit 1
fi
# Check if the database is ready (optional, useful for non-SQLite setups)
# echo "Waiting for database to be ready..."
# until python3 manage.py dbshell; do
#     sleep 1
# done

# Start the Django server with production-ready configurations
echo "Starting Django server with Gunicorn..."
exec gunicorn fermentrack.wsgi:application --bind 0.0.0.0:8080
