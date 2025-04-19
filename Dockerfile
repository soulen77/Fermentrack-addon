ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONPATH="/app"

# Install build dependencies
RUN apk add --no-cache \
    python3 py3-pip py3-psycopg2 \
    bash git gcc musl-dev libffi-dev \
    openssl-dev python3-dev cargo \
    jpeg-dev zlib-dev

# Create working directory
WORKDIR /app

# Clone Fermentrack
RUN git clone https://github.com/thorrak/fermentrack.git /app

# Copy in the addon startup script
COPY run.sh /app/run.sh
RUN chmod a+x /app/run.sh

# Use Fermentrack's requirements
RUN pip3 install --no-cache-dir -r /app/requirements.txt

# Fix default database path
ENV FERMENTRACK_DB_PATH="/config/fermentrack/db.sqlite3"

CMD [ "/app/run.sh" ]
