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
WORKDIR /app

# Copy Fermentrack source code
COPY fermentrack /app

# Create and activate virtualenv
RUN python3 -m venv /app/venv && \
    /app/venv/bin/pip install --upgrade pip && \
    /app/venv/bin/pip install --no-cache-dir -r requirements.txt gunicorn setuptools

# Copy run script
COPY run.sh /app/run.sh
RUN chmod +
