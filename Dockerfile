# Sử dụng Python image chính thức làm base image
FROM python:3.9-slim

# Tạo thư mục cho ứng dụng
WORKDIR /usr/src/app

# Tạo thư mục có quyền ghi
RUN mkdir /usr/src/app/data && chmod 777 /usr/src/app/data

# Cấp quyền thực thi cho các script CGI
RUN chmod +x /usr/src/app/cgi-bin/*

# Expose cổng 8000
EXPOSE 8000

# Chạy HTTP server với hỗ trợ CGI và phục vụ file tĩnh
CMD ["python", "-m", "http.server", "8000", "--cgi"]
