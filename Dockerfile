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

# Set working directory
WORKDIR /config/fermentrack

# Clone the Fermentrack repo
RUN git clone https://github.com/thorrak/fermentrack.git /config/fermentrack

# Set up virtual environment and install requirements
RUN python3 -m venv /config/fermentrack/venv && \
    /config/fermentrack/venv/bin/pip install --upgrade pip && \
    /config/fermentrack/venv/bin/pip install --no-cache-dir -r requirements.txt gunicorn setuptools

# Copy the run script
COPY run.sh /config/fermentrack/run.sh
RUN chmod +x /config/fermentrack/run.sh

# Set entrypoint
CMD ["/config/fermentrack/run.sh"]
