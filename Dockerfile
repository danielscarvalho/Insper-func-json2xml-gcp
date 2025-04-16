# Use the official Python image.
# https://hub.docker.com/_/python
FROM python:3.14-slim

# Copy local code to the container image.
ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

# Install production dependencies.
RUN pip install --no-cache-dir -r requirements.txt

# Run the web service on container startup.
CMD ["functions-framework", "--target=json2xml"]