#!/bin/bash

set -e  # Exit on any error

echo "Starting Fermentrack Add-on..."

# Set Django secret key
export DJANGO_SECRET_KEY="${DJANGO_SECRET_KEY:-default-secret-key}"

# Run database migrations
echo "Running database migrations..."
python3 manage.py migrate

# Collect static files
echo "Collecting static files..."
python3 manage.py collectstatic --noinput || true

# Start the Django server with Gunicorn
echo "Starting Django server with Gunicorn..."
exec gunicorn fermentrack_django.wsgi:application --bind 0.0.0.0:8080 --workers 3 --log-level info

