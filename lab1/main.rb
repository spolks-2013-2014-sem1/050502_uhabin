require '../spolks_lib/Sockets.rb'

socket = XTcpSocket.new('localhost', '3000')
socket.listen
socket.close