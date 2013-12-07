require '../spolks_lib/Sockets.rb'
require '../lab3/client.rb'
require './client.rb'

print "\nDestination file: "
filepath = gets.chomp

print "Select protocol(udp/tcp): "
protocol = gets.chomp
protocol.downcase!

case protocol
when 'udp'
  socket = XUdpSocket.new('localhost', '3000')
  client = UdpClient.new(socket, filepath)
when 'tcp'
  socket = XTcpSocket.new('localhost', '3000')
  client = TcpClient.new(socket, filepath)
else
  puts "Dont know what does #{protocol} means"
end
    
client.connect('localhost', '3000')