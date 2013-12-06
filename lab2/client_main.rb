require '../spolks_lib/Sockets.rb'
require './client.rb'

print "\nDestination file: "
filepath = gets.chomp

socket = XTcpSocket.new('localhost', '3000')
client = Client.new(socket, filepath)
client.connect('localhost', '3000')