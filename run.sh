#!/bin/bash

set -e

APP_DIR="/app/fermentrack"
DATA_DIR="/data"
SETTINGS_SRC="$DATA_DIR/settings_local.py"
SETTINGS_DST="$APP_DIR/fermentrack_django/settings_local.py"
DB_FILE="$DATA_DIR/db.sqlite3"

# Generate a default settings_local.py if not present
if [ ! -f /app/fermentrack/settings_local.py ]; then
    echo "Generating default settings_local.py..."
    # Commands to generate the filr
    cat <<EOF > "$SETTINGS_SRC"
DEBUG = False
ALLOWED_HOSTS = ['*']
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': '$DB_FILE',
    }
}
STATIC_ROOT = '$APP_DIR/static'
EOF
fi

# Copy settings_local.py into project
cp "$SETTINGS_SRC" "$SETTINGS_DST"

# Create DB if it doesn't exist
if [ ! -f "$DB_FILE" ]; then
    echo "Initializing database..."
    python3 manage.py migrate
fi

# Collect static files
echo "Collecting static files..."
python3 manage.py collectstatic --noinput

# Start the app with Gunicorn
echo "Starting Gunicorn..."
exec gunicorn fermentrack_django.wsgi:application \
    --bind 0.0.0.0:8080 \
    --workers 3 \
    --timeout 90
