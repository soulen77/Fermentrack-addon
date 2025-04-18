#!/bin/bash
set -e

# Set the environment variable for Django settings
export DJANGO_SETTINGS_MODULE=fermentrack.settings

# Initialize the database if necessary
if [ ! -f /app/fermentrack/settings_local.py ]; then
    cp /app/fermentrack/settings_local.py /app/fermentrack/settings_local.py
fi

# Run migrations
echo "Running database migrations..."
python3 /app/fermentrack/manage.py migrate --noinput

# Collect static files
echo "Collecting static files..."
python3 /app/fermentrack/manage.py collectstatic --noinput

# Start Gunicorn with 3 workers
echo "Starting Gunicorn..."
exec gunicorn fermentrack.wsgi:application --bind 0.0.0.0:8080 --workers 3 --chdir /app/fermentrack
