FROM debian:bullseye-slim

# Install prerequisites
RUN apt-get update && apt-get install -y \
    git python3 python3-pip python3-venv sqlite3 nginx \
    && apt-get clean

# Clone Fermentrack repository
RUN git clone https://github.com/thorrak/fermentrack.git /app/fermentrack \
    && cd /app/fermentrack \
    && pip3 install -r requirements.txt \
    && pip3 install django-constance[database]
RUN ls -l /app

# Set working directory
WORKDIR /app/fermentrack

# Set environment variables
ENV DJANGO_SECRET_KEY="your-secret-key"

CMD ["/run.sh"]


