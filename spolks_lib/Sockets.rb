require '../spolks_lib/BasicSocket.rb'
require '../spolks_lib/Constants.rb'

class XTcpSocket < BasicSocket
  attr_accessor :client_socket, :socket
  def initialize(host_name, port_number)
    create_socket(host_name, port_number)
  end
  def create_socket(host_name, port_number)
    @socket = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
    @sockaddr = Socket.sockaddr_in(port_number, host_name)
    begin
      @socket.bind(@sockaddr)
    rescue Errno::EADDRINUSE
      @socket.close
      create_socket(host_name, port_number)
    end
  end
  def listen
    @socket.listen(Constants::BACKLOG_VALUE)
    self.accept
  end
  def connect(sockaddr)
    @socket.connect(sockaddr)
  end
  def accept
    @client_socket, client_addrinfo = @socket.accept
    inspect_client(client_addrinfo)
  end
  def close
    @client_socket.close
    @socket.close
  end
end
