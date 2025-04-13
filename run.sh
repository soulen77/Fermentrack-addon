#!/usr/bin/env bash
set -e

# Define the Fermentrack app directory
FERMENTRACK_DIR="/app/"

# Change to the Fermentrack app directory
cd "$FERMENTRACK_DIR"

# Set up environment variables
export DJANGO_SETTINGS_MODULE=fermentrack.settings
export PYTHONPATH="$FERMENTRACK_DIR"

# If settings_local.py doesn't exist, generate it from example
if [ ! -f "$FERMENTRACK_DIR/settings_local.py" ]; then
    echo "Generating default settings_local.py..."
    cp settings_local.py "$FERMENTRACK_DIR/settings_local.py"
fi

# Run database migrations
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
