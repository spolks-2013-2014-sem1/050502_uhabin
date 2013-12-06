require '../spolks_lib/Sockets.rb'
require '../spolks_lib/Constants.rb'

class Client
  def initialize(socket, filepath)
    @socket = socket
    @file = File.open(filepath, 'w')
  end
  def connect(host_name, port_number)
    sockaddr = Socket.sockaddr_in(port_number, host_name)
    @socket.connect(sockaddr)
    self.receive_file {|chunk| @file.write(chunk)}
    @file.close
  end
  def receive_file
    loop do
      rs, _ = IO.select([@socket.socket], nil, nil, Constants::TIMEOUT)
        rs.each do |s|
          data = s.recv(Constants::CHUNK_SIZE)
          return if data.empty?
          if block_given?
            yield data
          end
        end
      end        
  end
end

