#!/usr/bin/env bash
cd /app

# Set up DB path override
export DJANGO_SETTINGS_MODULE=fermentrack_django.settings

# Apply migrations
python3 manage.py migrate --noinput

# Start Gunicorn on port 8080
gunicorn fermentrack_django.wsgi:application --bind 0.0.0.0:8080
