#!/usr/bin/env bash
set -e

DB_SRC="/config/fermentrack/db.sqlite3"
DB_DST="/app/fermentrack/db.sqlite3"

# Create destination directory if needed
mkdir -p /config/fermentrack

# If database doesn't exist, initialize it
if [ ! -f "$DB_SRC" ]; then
    echo "[INFO] No existing DB, running initial migrations..."
    cd /app/fermentrack
    python3 manage.py migrate
    cp "$DB_DST" "$DB_SRC"
else
    echo "[INFO] Found existing DB, using it"
    cp "$DB_SRC" "$DB_DST"
fi

# Start Fermentrack with gunicorn on port 8000
cd /app/fermentrack
exec gunicorn fermentrack_django.wsgi:application --bind 0.0.0.0:8000
