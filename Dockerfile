# Base image with specified platform
FROM --platform=linux/amd64 python:3.8-slim-buster as build

# Install essential packages
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
     build-essential \
  && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /usr/src/app

# Copy requirements and install dependencies
COPY requirements.txt ./
RUN pip install -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the application port
EXPOSE 80

# Run Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:80"]
