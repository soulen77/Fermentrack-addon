#!/usr/bin/env bash
cd /config/fermentrack

# Fetch DJANGO_SECRET_KEY from Home Assistant add-on options
export DJANGO_SECRET_KEY="${Django_Secret_Key:-changeme123}"

# Activate virtual environment
source /config/fermentrack/venv/bin/activate

# Run migrations
python manage.py migrate --noinput

# Collect static files
python manage.py collectstatic --noinput

# Start Gunicorn
exec /config/fermentrack/venv/bin/gunicorn fermentrack_django.wsgi:application --bind 0.0.0.0:8080
