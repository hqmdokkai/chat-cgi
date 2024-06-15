#!/usr/bin/env python3
import cgi
import cgitb
import os

# Bật báo cáo lỗi chi tiết
cgitb.enable()

def load_messages():
    if not os.path.exists('messages.txt'):
        return []
    with open('messages.txt', 'r') as file:
        messages = file.readlines()
    return messages

def save_message(username, message):
    with open('messages.txt', 'a') as file:
        file.write(f"{username}: {message}\n")  # Ghi username cùng với message

# Xử lý dữ liệu từ form
form = cgi.FieldStorage()

# Kiểm tra xem có dữ liệu username và message từ form không
if 'username' in form and 'message' in form:
    username = form.getvalue("username")
    message = form.getvalue("message")
    if username and message:
        save_message(username, message)
    # Chuyển hướng người dùng về trang chat.html
    print("Location: chat.html\n")
    print("\n")  # Kết thúc headers với một dòng trống
else:
    # Nếu không có dữ liệu từ form, trả về text/plain
    print("Content-Type: text/plain\n")
    print("\n")  # Kết thúc headers với một dòng trống
    messages = load_messages()
    for msg in messages:
        print(msg.strip())

# In ra mã HTML
print("""
<html>
  <head>
    <title>Simple Chat</title>
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        var usernameInput = document.getElementById("username");
        var savedUsername = sessionStorage.getItem("chatUsername");
        if (savedUsername) {
          usernameInput.value = savedUsername;
        }

        function refreshMessages() {
          var xhttp = new XMLHttpRequest();
          xhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
              document.getElementById("messages").innerHTML = this.responseText;
            }
          };
          xhttp.open("GET", "cgi-bin/main.py", true);
          xhttp.send();
        }
        setInterval(refreshMessages, 3000); // Refresh messages every 3 seconds

        document
          .getElementById("chatForm")
          .addEventListener("submit", function (event) {
            event.preventDefault(); // Ngăn không cho form submit theo cách thông thường
            var formData = new FormData(this);
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
              if (this.readyState == 4 && this.status == 200) {
                document.getElementById("messages").innerHTML =
                  this.responseText;
                refreshMessages(); // Refresh messages to show the latest ones
              }
            };
            xhttp.open("POST", "cgi-bin/main.py", true);
            xhttp.send(formData);

            var username = usernameInput.value;
            sessionStorage.setItem("chatUsername", username); // Lưu username vào sessionStorage
          });
      });
    </script>
  </head>
  <body onload="refreshMessages()">
    <h1>Simple Chat</h1>
    <form id="chatForm" method="POST" action="cgi-bin/main.py">
      <input
        type="text"
        id="username"
        name="username"
        placeholder="Username"
        size="15"
        required
      />
      <input
        type="text"
        name="message"
        size="45"
        placeholder="Enter message here"
        required
      />
      <input type="submit" value="Send" />
    </form>
    <pre id="messages"><!-- Placeholder for messages --></pre>
  </body>
</html>
""")
