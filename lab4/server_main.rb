require '../spolks_lib/Sockets.rb'
require '../lab3/server.rb'
require './server.rb'

print "\nDestination file: "
filepath = gets.chomp

print "Select protocol(udp/tcp): "
protocol = gets.chomp
protocol.downcase!

case protocol
when 'udp'
  socket = XUdpSocket.new('localhost', '3000')
  client = UdpServer.new(socket, filepath)
when 'tcp'
  socket = XTcpSocket.new('localhost', '3000')
  client = TcpServer.new(socket, filepath)
else
  puts "Dont know what does #{protocol} means"
end

server.start
server.stop