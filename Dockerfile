FROM debian:bullseye-slim

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    python3 \
    python3-pip \
    python3-venv \
    sqlite3 \
    nginx \
    && apt-get clean

# Clone Fermentrack and install Python dependencies
RUN git clone https://github.com/thorrak/fermentrack.git /app/fermentrack && \
    cd /app/fermentrack && \
    pip3 install -r requirements.txt && \
    pip3 install django-constance[database] gunicorn

# Copy run script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# Create required folders
RUN mkdir -p /data

# Set environment variables
ENV DJANGO_SECRET_KEY=supersecret \
    FERMENTRACK_DATA_PATH=/data

# Set working directory
WORKDIR /app/fermentrack

# Expose the web port
EXPOSE 8080

COPY run.sh /app/fermentrack/run.sh
RUN chmod +x /app/fermentrack/run.sh
CMD ["/app/fermentrack/run.sh"]

