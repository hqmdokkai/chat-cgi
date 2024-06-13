# Sử dụng một hình ảnh Python cơ bản
FROM python:latest

# Cài đặt Apache và các gói cần thiết
RUN apt-get update && \
    apt-get install -y apache2 \
    && rm -rf /var/lib/apt/lists/*

# Cấu hình Apache để hỗ trợ CGI và mod_cgi
RUN a2enmod cgi

# Sao chép các tệp CGI vào vị trí thích hợp
COPY cgi-bin/ /usr/lib/cgi-bin/

# Thiết lập thư mục làm việc mặc định cho Apache
WORKDIR /var/www/html

# Khởi động Apache khi container khởi chạy
CMD ["apache2ctl", "-D", "FOREGROUND"]
