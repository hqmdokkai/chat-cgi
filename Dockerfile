# Sử dụng Alpine Linux làm base image
FROM alpine:latest

# Cài đặt Apache và các gói phụ trợ
RUN apk --no-cache add apache2 python3

# Bật module CGI của Apache
RUN sed -i 's/#LoadModule cgid_module/LoadModule cgid_module/' /etc/apache2/httpd.conf

# Tạo thư mục cgi-bin và sao chép các tập tin CGI vào đó
RUN mkdir /usr/lib/cgi-bin
COPY cgi-bin/ /usr/lib/cgi-bin/

# Thiết lập thư mục làm việc của Apache
WORKDIR /var/www/localhost/htdocs

# Khởi động Apache
CMD ["httpd", "-D", "FOREGROUND"]
