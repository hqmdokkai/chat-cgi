# Sử dụng ảnh Python trên nền Debian
FROM python:3.9-slim

# Cài đặt Apache
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean

# Enable module CGI
RUN a2enmod cgi

# Tạo thư mục cgi-bin và sao chép file main.py vào đó
RUN mkdir -p /usr/lib/cgi-bin
COPY main.py /usr/lib/cgi-bin/main.py

# Set quyền thực thi cho file CGI
RUN chmod +x /usr/lib/cgi-bin/main.py

# Expose port 80 để truy cập web
EXPOSE 80
