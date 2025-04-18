#!/usr/bin/env bash
set -e

# Path to Fermentrack
FERMENTRACK_DIR="/app/fermentrack"

cd "$FERMENTRACK_DIR"

# Set environment variables
export DJANGO_SETTINGS_MODULE=fermentrack.settings
export PYTHONPATH="$FERMENTRACK_DIR"

# Run migrations
echo "Applying database migrations..."
python3 manage.py migrate --noinput

# Collect static files
echo "Collecting static files..."
python3 manage.py collectstatic --noinput

# Start Gunicorn
echo "Starting Fermentrack with Gunicorn..."
exec /usr/local/bin/gunicorn fermentrack.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 3 \
    --chdir "$FERMENTRACK_DIR"
