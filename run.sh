#!/bin/bash

set -e  # Exit on any error

echo "Starting Fermentrack Add-on..."

# Set Django secret key
export DJANGO_SECRET_KEY="${DJANGO_SECRET_KEY:-default-secret-key}"

# Set the working directory to the Fermentrack app
cd /app/fermentrack

# Add the current directory to the Python path
export PYTHONPATH=/app/fermentrack:$PYTHONPATH

# Ensure __init__.py exists in the Fermentrack directory
echo "Ensuring __init__.py exists in the Fermentrack directory..."
touch /app/fermentrack/__init__.py

# Run database migrations
echo "Running database migrations..."
if ! python3 manage.py migrate; then
    echo "Migration failed. Check the logs for details."
    exit 1
fi

# Start the Django server with production-ready configurations
echo "Starting Django server with Gunicorn..."
exec gunicorn fermentrack.wsgi:application --bind 0.0.0.0:8080 --workers 3 --log-level info

