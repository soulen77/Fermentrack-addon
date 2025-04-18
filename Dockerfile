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

# Clone Fermentrack
RUN git clone https://github.com/thorrak/fermentrack.git /app/fermentrack

# Install Python dependencies
WORKDIR /app/fermentrack
RUN pip3 install -r requirements.txt && \
    pip3 install django-constance[database] gunicorn

# Copy local config files
COPY run.sh /app/fermentrack/run.sh
COPY fermentrack/settings_local.py /app/fermentrack/fermentrack/settings_local.py
RUN chmod +x /app/fermentrack/run.sh

# Set working directory and expose port
WORKDIR /app/fermentrack
EXPOSE 8080

CMD ["/app/fermentrack/run.sh"]
