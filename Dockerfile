# Use a stable Python slim image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements first for caching
COPY requirements.txt .

# Install dependencies with error handling
RUN pip install --no-cache-dir -r requirements.txt && \
    pip install gunicorn && \
    pip install flask

# Copy application code
COPY main.py .

# Expose port 5000
EXPOSE 5000

# Set environment variables
ENV PORT=5000
ENV FLASK_ENV=production
ENV GUNICORN_LOGLEVEL=debug

# Healthcheck to ensure container is responsive
HEALTHCHECK --interval=120s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

# Run Gunicorn with debug logging
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--log-level=debug", "main:app"]