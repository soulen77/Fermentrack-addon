# Use a different Python base image if necessary
FROM python:3.11-slim

# Install required dependencies for building the Fermentrack add-on
RUN apt-get update \
    && apt-get install -y \
    build-essential \
    libffi-dev \
    libssl-dev \
    libpq-dev \
    python3-dev \
    python3-pip \
    libjpeg-dev \
    zlib1g-dev \
    liblcms2-dev \
    libblas-dev \
    liblapack-dev \
    gfortran \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy Fermentrack source code into the container
COPY . /app

# Install Python dependencies
RUN pip install -r requirements.txt

# Set up the environment for Django
ENV PYTHONUNBUFFERED 1
ENV PYTHONPATH="/app"

# Expose the necessary port
EXPOSE 8080

# Command to run Fermentrack application
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "fermentrack.wsgi:application"]
