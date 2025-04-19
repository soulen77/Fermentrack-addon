#!/usr/bin/env bash
cd /app

# Activate the virtual environment
. /app/venv/bin/activate

# Apply database migrations
python3 manage.py migrate --noinput

# Start Gunicorn as PID 1
exec gunicorn fermentrack_django.wsgi:application --bind 0.0.0.0:8080
