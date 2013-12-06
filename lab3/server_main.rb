require '../SPOLKS_LIB/Sockets/XTCPSocket.rb'
require '../SPOLKS_LIB/Utility/UserOptionsParser.rb'
require_relative 'server.rb'

parser = UserOptionsParser.new
options = parser.parse

socket = XTCPSocket.new(options.get_port_number, options.get_host_name)
server = TCPServer.new(socket, options.get_filepath)
server.start
server.stop