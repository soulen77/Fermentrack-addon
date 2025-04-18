#!/usr/bin/env bash

# Exit on error
set -e

# Move to the app directory
cd /app/fermentrack

# Ensure environment variables (optional - customize as needed)
export PYTHONUNBUFFERED=1
export DJANGO_SETTINGS_MODULE=fermentrack.settings

# Run database migrations (optional but recommended)
python3 manage.py migrate --noinput

# Collect static files (optional, depending on your setup)
python3 manage.py collectstatic --noinput

# Start Gunicorn, pointing to the correct module
exec gunicorn fermentrack.wsgi:application \
    --bind 0.0.0.0:8080 \
    --workers 3 \
    --threads 2 \
    --timeout 120
