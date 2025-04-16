# Use the official Python slim image for a smaller footprint
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file to install dependencies
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY app.py .

# Install Gunicorn for production-grade WSGI server
RUN pip install gunicorn

# Expose port 8080 (Cloud Run default)
EXPOSE 8080

# Set environment variables for Flask and Cloud Run
ENV PORT=8080
ENV FLASK_ENV=production

# Run Gunicorn to serve the Flask app
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "app:app"]