ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONPATH="/app"


# Install dependencies
RUN apk add --no-cache \
    python3 py3-pip py3-psycopg2 \
    bash git gcc musl-dev libffi-dev \
    openssl-dev python3-dev cargo \
    jpeg-dev zlib-dev

# Set working directory
WORKDIR /app

# Clone Fermentrack repo
RUN git clone https://github.com/thorrak/fermentrack.git /app

# Copy startup script
COPY run.sh /app/run.sh
RUN chmod a+x /app/run.sh

# Create virtual environment and install dependencies inside it
RUN python3 -m venv /app/venv && \
    . /app/venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r /app/requirements.txt

# Ensure app uses venv python
ENV PATH="/app/venv/bin:$PATH"

# Environment for Fermentrack DB persistence
ENV FERMENTRACK_DB_PATH="/config/fermentrack/db.sqlite3"

# Start app
CMD [ "/app/run.sh" ]
