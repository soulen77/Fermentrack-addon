#!/usr/bin/with-contenv bashio

# Paths
DB_SRC="/data/fermentrack/db.sqlite3"
DB_DEST="/app/fermentrack/db.sqlite3"

# Ensure /data/fermentrack exists
mkdir -p /data/fermentrack

# Initialize DB if it doesn't exist
if [ ! -f "$DB_SRC" ]; then
    echo "[INFO] Creating new SQLite database at $DB_SRC"
    python3 /app/fermentrack/manage.py migrate
    cp /app/fermentrack/db.sqlite3 "$DB_SRC"
fi

# Link or copy the DB to Fermentrack app directory
if [ ! -f "$DB_DEST" ]; then
    ln -s "$DB_SRC" "$DB_DEST"
fi

# Collect static files (optional, if using whitenoise/static)
python3 /app/fermentrack/manage.py collectstatic --noinput

# Start the application
echo "[INFO] Starting Fermentrack via Gunicorn..."
cd /app/fermentrack
exec gunicorn -b 0.0.0.0:8080 fermentrack_django.wsgi:application
