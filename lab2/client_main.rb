require '../SPOLKS_LIB/Sockets/XTCPSocket.rb'
require '../SPOLKS_LIB/Utility/UserOptionsParser.rb'
require 'client.rb'

socket = XTCPSocket.new('localhost', '3000')
client = Client.new(socket, filepath)
client.connect('localhost', '3000')