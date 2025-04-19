# Set working directory
WORKDIR /data/fermentrack

# Clone the repo
RUN git clone https://github.com/thorrak/fermentrack.git /data/fermentrack

# Install and activate virtualenv
RUN python3 -m venv /opt/fermentrack/venv && \
    /data/fermentrack/venv/bin/pip install --upgrade pip && \
    /data/fermentrack/venv/bin/pip install --no-cache-dir -r /data/fermentrack/requirements.txt gunicorn setuptools

# Copy run script
COPY run.sh /data/fermentrack/run.sh
RUN chmod +x /data/fermentrack/run.sh

# Entrypoint
CMD ["/data/fermentrack/run.sh"]
