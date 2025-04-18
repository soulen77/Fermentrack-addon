#!/bin/bash

# Apply database migrations
python3 manage.py migrate --noinput

# Collect static files
python3 manage.py collectstatic --noinput

# Run Gunicorn
gunicorn --bind 0.0.0.0:8080 fermentrack.wsgi:application
