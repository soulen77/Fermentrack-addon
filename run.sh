#!/usr/bin/env bash

DB_FILE="/config/fermentrack/db.sqlite3"

# Ensure the destination directory exists
mkdir -p /config/fermentrack

# If the DB doesn't exist, initialize it
if [ ! -f "$DB_FILE" ]; then
    echo "Database not found, running migrations..."
    python3 /app/fermentrack/manage.py migrate
    cp /app/fermentrack/db.sqlite3 "$DB_FILE"
else
    echo "Using existing database"
    cp "$DB_FILE" /app/fermentrack/db.sqlite3
fi

# Start the app
cd /app/fermentrack
exec gunicorn fermentrack_django.wsgi:application --bind "0.0.0.0:8000"
