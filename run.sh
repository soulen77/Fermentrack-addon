#!/bin/bash

# Ensure the Fermentrack directory exists in persistent storage
mkdir -p "${FERMENTRACK_DATA_PATH}"

# Link db.sqlite3 to persistent storage
if [ ! -f "${FERMENTRACK_DATA_PATH}/db.sqlite3" ]; then
    cp /app/fermentrack/db.sqlite3 "${FERMENTRACK_DATA_PATH}/db.sqlite3"
fi
ln -sf "${FERMENTRACK_DATA_PATH}/db.sqlite3" /app/fermentrack/db.sqlite3

# (Same can be done for logs, backups, or media folders if needed)

# Run Fermentrack
cd /app/fermentrack
exec gunicorn fermentrack_django.wsgi:application --bind 0.0.0.0.8080
