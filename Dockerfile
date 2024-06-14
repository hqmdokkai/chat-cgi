# Sử dụng Python image chính thức làm base image
FROM python:3.9-slim

# Tạo thư mục cho các CGI script
WORKDIR /usr/src/app/cgi-bin

# Sao chép các CGI script vào thư mục cgi-bin
COPY cgi-bin/ /usr/src/app/cgi-bin/

# Tạo thư mục có quyền ghi
RUN mkdir /usr/src/app/data && chmod 777 /usr/src/app/data

# Cấp quyền thực thi cho các script CGI
RUN chmod +x /usr/src/app/cgi-bin/*

# Expose cổng 8000
EXPOSE 8000

# Chạy HTTP server với hỗ trợ CGI
CMD ["python", "-m", "http.server", "8000", "--cgi"]
