# Use the official Python base image
FROM ghcr.io/hassio-addons/base-python:3.11

# Set environment variables
ENV LANG C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV DJANGO_SETTINGS_MODULE=fermentrack_django.settings

# Set working directory
WORKDIR /app

# Copy the source code to the container
COPY . /app

# Install Python dependencies
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# Collect static files
RUN python manage.py collectstatic --noinput || true

# Expose port 8080 (default for Fermentrack)
EXPOSE 8080

# Start the app using Gunicorn
CMD ["gunicorn", "fermentrack_django.wsgi:application", "--bind", "0.0.0.0:8080"]
