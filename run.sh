#!/usr/bin/env bash
cd /config/fermentrack

# Fetch DJANGO_SECRET_KEY from Home Assistant add-on options
export DJANGO_SECRET_KEY="${Django_Secret_Key:-changeme123}"

# Optional: Link /config if needed for persistent storage
if [ ! -d /config/fermentrack ]; then
    mkdir -p /config/fermentrack
fi

ln -sf /config/fermentrack/db.sqlite3 /opt/fermentrack/db.sqlite3

# Activate virtual environment
source /config/fermentrack/venv/bin/activate

# Run migrations
python manage.py migrate --noinput

# Collect static files
python manage.py collectstatic --noinput

# Start Gunicorn
exec /config/fermentrack/venv/bin/gunicorn fermentrack_django.wsgi:application --bind 0.0.0.0:8080
