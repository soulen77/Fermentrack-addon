#!/usr/bin/env bash

cd /app
source venv/bin/activate
export DJANGO_SETTINGS_MODULE=fermentrack_django.settings

python manage.py migrate --noinput

# Launch from project directory
cd fermentrack_django
gunicorn fermentrack_django.wsgi:application --bind 0.0.0.0:8080
