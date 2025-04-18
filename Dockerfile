FROM ghcr.io/home-assistant/base-debian:bullseye

ENV LANG C.UTF-8

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    python3-venv \
    nginx \
    sqlite3 \
    && apt-get clean

# Set up working directory
WORKDIR /app

# Clone Fermentrack
RUN git clone https://github.com/thorrak/fermentrack.git /app/fermentrack

# Install Python dependencies
WORKDIR /app/fermentrack
RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install --no-cache-dir gunicorn django-constance[database]

# Copy local settings
COPY settings_local.py /app/fermentrack/settings_local.py
COPY run.sh /app/fermentrack/run.sh
RUN chmod +x /app/fermentrack/run.sh

# Expose port
EXPOSE 8080

# Entry point
CMD ["/app/fermentrack/run.sh"]
