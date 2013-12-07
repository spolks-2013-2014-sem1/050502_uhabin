require '../spolks_lib/Sockets.rb'

class UdpServer
  def initialize(socket, filepath)
    @socket = socket
    @file = File.open(filepath, 'rb')
  end
  def start
    @socket.bind
    @socket.listen
    self.send_file
  end
  def send_file
    while (chunk = @file.read(Constants::CHUNK_SIZE / Constants::CHUNK_SIZE_DIVIDER_FOR_UDP))
      @socket.send(chunk, 0, @socket.client_sockaddr)
    end
    @socket.send('#', 0, @socket.client_sockaddr)
  end
  def stop
    @socket.close
    @file.close
  end
end