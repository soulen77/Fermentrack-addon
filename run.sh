#!/bin/bash

# Ensure that the database is initialized (only run once)
python3 /app/manage.py migrate --noinput || true

# Start the Gunicorn server
exec gunicorn fermentrack_django.wsgi:application --bind 0.0.0.0:8080
