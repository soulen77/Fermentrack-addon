#!/usr/bin/env bash
set -e

cd /app

# Set environment variable for Django to find the settings
export DJANGO_SETTINGS_MODULE=fermentrack_django.settings

# Run Django migrations and collect static files
python3 manage.py migrate --noinput
python3 manage.py collectstatic --noinput

# Start Gunicorn
gunicorn fermentrack_django.wsgi:application \
    --bind 0.0.0.0:8080 \
    --workers 3
