FROM python:3.9-slim

# Cài đặt Apache và CGI
RUN apt-get update && apt-get install -y apache2 && a2enmod cgi

# Sao chép mã của bạn vào thư mục CGI
WORKDIR /var/www/html/cgi-bin
COPY . .

# Cấp quyền thực thi cho tập tin CGI
RUN chmod +x main.py

# Khởi động Apache
CMD ["apache2ctl", "-D", "FOREGROUND"]
