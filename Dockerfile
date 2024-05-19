# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Install lighttpd
RUN apt-get update && apt-get install -y lighttpd && rm -rf /var/lib/apt/lists/*

# Copy the current directory contents into the container at /app
COPY . /app
WORKDIR /app

# Make sure the CGI script has execute permissions
RUN chmod +x /app/cgi-bin/main.py

# Configure lighttpd
RUN lighty-enable-mod cgi
COPY lighttpd.conf /etc/lighttpd/lighttpd.conf

# Expose port 80 to the outside world
EXPOSE 80

# Run lighttpd when the container launches
CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
