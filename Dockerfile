# Use a stable Python slim image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements first for caching
COPY requirements.txt .

# Install dependencies with error handling
RUN pip install --no-cache-dir -r requirements.txt && \
    pip install gunicorn

# Copy application code
COPY main.py .

# Expose port 8080
EXPOSE 8080

# Set environment variables
ENV PORT=8080
ENV FLASK_ENV=production
ENV GUNICORN_LOGLEVEL=debug

# Healthcheck to ensure container is responsive
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

# Run Gunicorn with debug logging
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "--log-level=debug", "main:app"]