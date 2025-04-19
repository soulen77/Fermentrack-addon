# Set the base image
ARG BUILD_FROM
FROM $BUILD_FROM

# Set environment variables
ENV LANG C.UTF-8

# Install dependencies
RUN apk add --no-cache \
    python3 \
    py3-pip \
    py3-virtualenv \
    libffi-dev \
    openssl-dev \
    gcc \
    musl-dev \
    python3-dev \
    git \
    py3-setuptools \
    postgresql-dev \
    jpeg-dev \
    zlib-dev \
    bash

# Setup app directory
WORKDIR /data/fermentrack

# Clone the Fermentrack repository
RUN git clone https://github.com/thorrak/fermentrack.git /data/fermentrack

# Create and activate virtualenv in the working directory
RUN python3 -m venv /config/fermentrack/venv && \
    /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install --no-cache-dir -r /data/fermentrack/requirements.txt gunicorn setuptools

# Copy run script to the correct directory
COPY run.sh /data/fermentrack/run.sh
RUN chmod +x /data/fermentrack/run.sh

# Debug: List directory contents and print script
RUN ls -l /data/fermentrack && echo "--- run.sh ---" && cat /data/fermentrack/run.sh

# Set entrypoint
CMD ["/data/fermentrack/run.sh"]
