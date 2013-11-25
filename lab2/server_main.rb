require '../SPOLKS_LIB/Sockets/XTCPSocket.rb'
require '../SPOLKS_LIB/Utility/UserOptionsParser.rb'
require 'server.rb'

socket = XTCPSocket.new('localhost', '3000')
server = Server.new(socket, filepath)
server.start
server.stop