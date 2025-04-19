#!/usr/bin/env bash
cd /app

# Ensure database migrations are applied
python3 manage.py migrate --noinput

# Start Gunicorn with the correct WSGI app
gunicorn fermentrack_django.wsgi:application --bind 0.0.0.0:8080
