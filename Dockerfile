# Dockerfile

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

# Clone the Fermentrack repo and install dependencies
RUN git clone https://github.com/thorrak/fermentrack.git /app/fermentrack && \
    cd /app/fermentrack && \
    pip3 install -r requirements.txt && \
    pip3 install django-constance[database] gunicorn

# Copy the config and run script
COPY settings_local.py /app/fermentrack/settings_local.py
COPY scripts/run /app/fermentrack/run.sh
COPY scripts/fermentrack-run scripts/fermentrack-ru

# Set the entry point for running Fermentrack
ENTRYPOINT ["/scripts/fermentrack-run"]
