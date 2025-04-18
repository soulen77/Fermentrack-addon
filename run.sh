#!/usr/bin/env bash

set -e

# Go to the outer project root where manage.py lives
cd /app/fermentrack

# Optional: export custom settings module
export DJANGO_SETTINGS_MODULE=fermentrack.settings

# Apply migrations and collect static
python3 manage.py migrate --noinput
python3 manage.py collectstatic --noinput

# Start Gunicorn
exec gunicorn fermentrack.wsgi:application \
    --bind 0.0.0.0:8080 \
    --workers 3 \
    --threads 2 \
    --timeout 120
