# Sử dụng image gốc từ Debian
FROM debian:bookworm

# Cài đặt Apache và các gói phụ trợ
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get install -y python3

# Bật module CGI của Apache
RUN a2enmod cgi

# Sao chép các tập tin CGI vào container
COPY cgi-bin/ /usr/lib/cgi-bin/

# Thiết lập thư mục làm việc của Apache
WORKDIR /var/www/html

# Khởi động Apache
CMD ["apache2ctl", "-D", "FOREGROUND"]
