FROM debian:bullseye-slim

SHELL ["/bin/bash", "-c"]

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    python3-venv \
    sqlite3 \
    nginx \
    && apt-get clean

# Clone Fermentrack and install Python dependencies
RUN git clone https://github.com/thorrak/fermentrack.git /app/fermentrack && \
    cd /app/fermentrack && \
    pip3 install -r requirements.txt && \
    pip3 install django-constance[database] gunicorn

# Create required folders
RUN mkdir -p /data

# Set environment variables
ENV DJANGO_SECRET_KEY=supersecret \
    FERMENTRACK_DATA_PATH=/data \
    PYTHONPATH=/app/fermentrack

# Set working directory
WORKDIR /app/fermentrack

# Expose the web port
EXPOSE 8080

# Copy run.sh and ensure it's executable
COPY run.sh /app/fermentrack/run.sh
COPY settings_local.py /app/fermentrack/settings_local.py
RUN chmod +x /app/fermentrack/run.sh

# Run the startup script
CMD ["/bin/bash", "/app/fermentrack/run.sh"]
