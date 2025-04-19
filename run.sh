#!/usr/bin/env bash
cd /opt/fermentrack

export DJANGO_SECRET_KEY="${Django_Secret_Key:-changeme123}"

source /opt/fermentrack/venv/bin/activate

python manage.py migrate --noinput
python manage.py collectstatic --noinput

exec /opt/fermentrack/venv/bin/gunicorn fermentrack_django.wsgi:application --bind 0.0.0.0:8080
