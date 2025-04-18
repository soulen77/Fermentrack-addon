#!/bin/bash
# /scripts/run.sh

# Ensure that virtual environment is activated
source /app/fermentrack/venv/bin/activate

# Run the Fermentrack application (this is optional, if you want to run additional tasks before Fermentrack)
exec gunicorn --bind 0.0.0.0:8080 fermentrack.wsgi:application
