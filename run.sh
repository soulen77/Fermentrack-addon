#!/usr/bin/with-contenv bashio

export FERMENTRACK_BASE=/config/fermentrack
cd /app/fermentrack

# Ensure persistent data directory exists
mkdir -p "$FERMENTRACK_BASE"

# Generate settings_local.py if it doesn't exist
if [ ! -f "$FERMENTRACK_BASE/settings_local.py" ]; then
  echo "Generating default settings_local.py..."
  echo "# Local settings override" > "$FERMENTRACK_BASE/settings_local.py"
fi

# Symlink settings_local.py so Django uses the persistent one
ln -sf "$FERMENTRACK_BASE/settings_local.py" /app/fermentrack/settings_local.py

# Initialize database if it doesn't exist
if [ ! -f "$FERMENTRACK_BASE/db.sqlite3" ]; then
  echo "Creating persistent database..."
  python3 manage.py migrate
  cp db.sqlite3 "$FERMENTRACK_BASE/db.sqlite3"
fi

# Symlink persistent database
ln -sf "$FERMENTRACK_BASE/db.sqlite3" /app/fermentrack/db.sqlite3

# Run migrations again (safe even if already applied)
echo "Initializing database..."
python3 manage.py migrate --noinput

# Collect static files
echo "Collecting static files..."
python3 manage.py collectstatic --noinput

# Start Gunicorn with the correct WSGI module
exec gunicorn fermentrack.wsgi:application \
    --bind 0.0.0.0:8080 \
    --workers 3
