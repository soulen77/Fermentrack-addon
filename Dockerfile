FROM debian:bullseye-slim

# Install dependencies
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
RUN curl -L https://github.com/just-containers/s6-overlay/releases/download/v3.1.1.0/s6-overlay-aarch64.tar.gz | tar xzf - -C /

# Clone the Fermentrack repo and install dependencies
RUN git clone https://github.com/thorrak/fermentrack.git /app/fermentrack && \
    cd /app/fermentrack && \
    pip3 install -r requirements.txt && \
    pip3 install django-constance[database] gunicorn

# Create the directories for services
RUN mkdir -p /etc/services.d/gunicorn /etc/services.d/nginx /app/fermentrack

# Copy your configuration and entrypoint files
COPY settings_local.py /app/fermentrack/settings_local.py
COPY run.sh /app/fermentrack/run.sh

# Expose the web port
EXPOSE 8080

# Set the entrypoint to use s6-overlay
ENTRYPOINT ["/init"]

