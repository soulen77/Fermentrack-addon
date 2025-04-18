FROM ghcr.io/home-assistant/aarch64-base-debian:bullseye

# Install required dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    python3-venv \
    sqlite3 \
    nginx \
    curl \
    && apt-get clean

# Install s6-overlay
RUN curl -L https://github.com/just-containers/s6-overlay/releases/download/v3.1.1.0/s6-overlay-amd64.tar.gz | tar xz -C /

# Set up directories
RUN mkdir -p /app/fermentrack /config /data

# Clone the Fermentrack repository
RUN git clone https://github.com/thorrak/fermentrack.git /app/fermentrack && \
    cd /app/fermentrack && \
    pip3 install -r requirements.txt && \
    pip3 install django-constance[database] gunicorn

# Copy configuration files
COPY settings_local.py /app/fermentrack/settings_local.py
COPY run.sh /app/fermentrack/run.sh
RUN chmod +x /app/fermentrack/run.sh

# Expose the port
EXPOSE 8080

# Use s6-overlay as the entrypoint
ENTRYPOINT ["/init"]
CMD ["/app/fermentrack/run.sh"]

