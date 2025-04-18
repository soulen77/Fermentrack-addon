#!/usr/bin/env bash
set -e

FERMENTRACK_DIR="/app/fermentrack"
DATA_DIR="/config/fermentrack"

mkdir -p "$DATA_DIR"

cd "$FERMENTRACK_DIR"

# Use persistent DB path
export DJANGO_SETTINGS_MODULE=fermentrack.settings
export FERMENTRACK_DATA_PATH="$DATA_DIR"

# Link or copy settings if needed
if [ ! -f "$FERMENTRACK_DIR/settings_local.py" ]; then
    cp /app/fermentrack/settings_local.py "$FERMENTRACK_DIR/settings_local.py"
fi

echo "Running migrations..."
python3 manage.py migrate --noinput

echo "Collecting static files..."
python3 manage.py collectstatic --noinput

echo "Starting Gunicorn..."
exec /usr/local/bin/gunicorn fermentrack.wsgi:application \
    --bind 0.0.0.0:8080 \
    --workers 3 \
    --chdir "$FERMENTRACK_DIR"
