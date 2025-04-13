#!/usr/bin/env bash
set -e

# Define the Fermentrack app directory
FERMENTRACK_DIR="/app/fermentrack"

# Change to the Fermentrack app directory
cd /app/fermentrack

# Set up environment variables if needed
export DJANGO_SETTINGS_MODULE=fermentrack.settings

# If settings_local.py doesn't exist, generate it
if [ ! -f "$FERMENTRACK_DIR/settings_local.py" ]; then
    echo "Generating default settings_local.py..."
    cp /app/fermentrack/fermentrack/settings_local.py.example /app/fermentrack/fermentrack/settings_local.py
fi

# Run migrations
echo "Initializing database..."
python3 manage.py migrate --noinput

# Collect static files
echo "Collecting static files..."
python3 manage.py collectstatic --noinput

# Start Gunicorn
echo "Starting Fermentrack with Gunicorn..."
exec gunicorn fermentrack.wsgi:application \
    --bind 0.0.0.0:8080 \
    --workers 3 \
    --chdir "$FERMENTRACK_DIR"
