ARG BUILD_FROM
FROM $BUILD_FROM

# Set environment variables
ENV LANG C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# Install dependencies
RUN apk add --no-cache \
    python3 py3-pip py3-psycopg2 \
    bash git gcc musl-dev libffi-dev \
    openssl-dev python3-dev cargo \
    jpeg-dev zlib-dev

# Set working directory
WORKDIR /app

# Clone Fermentrack repository
RUN git clone https://github.com/thorrak/fermentrack.git /app

# Create virtual environment and install requirements
RUN python3 -m venv /app/venv && \
    . /app/venv/bin/activate && \
    pip install --no-cache-dir -r /app/requirements.txt

ENV DJANGO_SECRET_KEY="your_super_secret_key_here"

# Copy startup script and make it executable
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

# Set entrypoint
ENTRYPOINT ["/app/run.sh"]
