# Production Containerfile for Google Cloud Run (AgriMitra AI)
FROM python:3.11-slim

# Prevent Python from writing .pyc and enable unbuffered logging
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8080 \
    APP_HOME=/app

WORKDIR $APP_HOME

# Install required system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt gunicorn

# Copy all application files
COPY . ./

# Cloud Run injects the PORT environment variable (default: 8080)
EXPOSE 8080

# Launch server with Gunicorn (1 worker, 8 threads for low-latency concurrent requests)
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 app:app
