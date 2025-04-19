# Set working directory
WORKDIR /opt/fermentrack

# Clone the repo
RUN git clone https://github.com/thorrak/fermentrack.git /opt/fermentrack

# Install and activate virtualenv
RUN python3 -m venv /opt/fermentrack/venv && \
    /opt/fermentrack/venv/bin/pip install --upgrade pip && \
    /opt/fermentrack/venv/bin/pip install --no-cache-dir -r /opt/fermentrack/requirements.txt gunicorn setuptools

# Copy run script
COPY run.sh /opt/fermentrack/run.sh
RUN chmod +x /opt/fermentrack/run.sh

# Entrypoint
CMD ["/opt/fermentrack/run.sh"]
