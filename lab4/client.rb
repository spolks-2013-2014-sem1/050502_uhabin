require '../SPOLKS_LIB/Sockets/XTCPSocket.rb'

class UdpClient
  def initialize(socket, filepath)
    @socket = socket
    @file = File.open(filepath, Constants::WRITE_FILE_FLAG)
  end
  def connect(host_name, port_number)
    sockaddr = Socket.sockaddr_in(port_number, host_name)
    @socket.send('#', 0, sockaddr)
    @socket.connect(sockaddr)
    self.receive_file {|chunk| @file.write(chunk)}
    @file.close
  end
  def receive_file
    loop do
      rs, _, us = IO.select([@socket.socket], nil, [@socket.socket], Constants::TIMEOUT)
      break unless rs
      rs.each do |s|
      data = s.recv(Constants::CHUNK_SIZE / Constants::CHUNK_SIZE_DIVIDER_FOR_UDP)
        return if (data.empty? || data == Constants::UDP_MESSAGE)
        if block_given?
          yield data
        end
      end
    end
  end
end