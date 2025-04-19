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
WORKDIR /config/fermentrack

# Clone the Fermentrack repository
RUN git clone https://github.com/thorrak/fermentrack.git /config/fermentrack

# Create and activate virtualenv in the working directory
RUN python3 -m venv /config/fermentrack/venv && \
    /config/fermentrack/venv/bin/pip install --upgrade pip && \
    /config/fermentrack/venv/bin/pip install --no-cache-dir -r /config/fermentrack/requirements.txt gunicorn setuptools

# Copy run script to the correct directory
COPY run.sh /config/fermentrack/run.sh
RUN chmod +x /config/fermentrack/run.sh

# Set entrypoint to use the correct path
CMD ["/config/fermentrack/run.sh"]
