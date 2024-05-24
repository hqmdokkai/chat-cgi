# Sử dụng hình ảnh cơ bản của Python
FROM python:3.9-slim

# Thiết lập thư mục làm việc
WORKDIR /app

# Sao chép các tệp của bạn vào container
COPY . /app

# Mở cổng mà http.server sẽ sử dụng
EXPOSE 8000

# Cài đặt quyền thực thi cho các script CGI
RUN chmod +x /app/cgi-bin/*.py

# Chạy http.server với hỗ trợ CGI
CMD ["python", "-m", "http.server", "8000", "--cgi"]
