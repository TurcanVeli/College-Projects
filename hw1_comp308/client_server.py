import socket




filename = 'index.html'
server_host = ""
server_port = 6379

C_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

C_socket.connect((server_host, server_port))

C_socket.sendall(f"GET /{filename} HTTP/1.1\r\nHost: {server_host}\r\n\r\n".encode())


response = C_socket.recv(1024)


while response:
    print(response.decode(), end="")

    response = C_socket.recv(1024)



C_socket.close()