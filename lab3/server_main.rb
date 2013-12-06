require '../spolks_lib/Sockets.rb'
require './server.rb'

print "\nSource file: "
filepath = gets.chomp

socket = XTcpSocket.new('localhost', '3000')
server = Server.new(socket, filepath)
server.start
server.stop