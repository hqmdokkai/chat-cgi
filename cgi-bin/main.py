#!/usr/bin/env python3
import cgi
import cgitb; cgitb.enable()  # Bật báo cáo lỗi chi tiết
import os

def load_messages():
    if not os.path.exists('messages.txt'):
        return []
    with open('messages.txt', 'r') as file:
        messages = file.readlines()
    return messages

def save_message(username, message):
    with open('messages.txt', 'a') as file:
        file.write(f"{username}: {message}\n")  # Ghi username cùng với message

form = cgi.FieldStorage()

if 'username' in form and 'message' in form:
    username = form.getvalue("username")
    message = form.getvalue("message")
    if username and message:
        save_message(username, message)
    print("Location: chat.html\n")  # Chuyển hướng người dùng về trang chat.html
    print("\n")  # Kết thúc headers với một dòng trống
else:
    print("Content-Type: text/plain\n")  # Chỉ trả về text/plain nếu không có dữ liệu form
    print("\n")  # Kết thúc headers với một dòng trống
    messages = load_messages()
    for msg in messages:
        print(msg.strip())