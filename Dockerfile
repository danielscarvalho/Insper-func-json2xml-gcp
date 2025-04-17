# Use the official Python image.
# https://hub.docker.com/_/python
FROM python:3.13-slim

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

# Install production dependencies.
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 8080 for Cloud Run
EXPOSE 8080

# Run the function using functions-framework
CMD ["functions-framework", "--target", "json2xml", "--port", "8080"]

# Run the web service on container startup.
#CMD ["functions-framework", "--target=json2xml"]