#!/usr/bin/env bash
cd /app

# Set a default secret key if none is provided
export DJANGO_SECRET_KEY="${DJANGO_SECRET_KEY:-changeme123}"

# Activate the virtual environment
. /app/venv/bin/activate

# Run migrations
python3 manage.py migrate --noinput

# Start Gunicorn using the venv version
exec /app/venv/bin/gunicorn fermentrack_django.wsgi:application --bind 0.0.0.0:8080
