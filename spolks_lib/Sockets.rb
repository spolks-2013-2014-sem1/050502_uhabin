require '../spolks_lib/BasicSocket.rb'
require '../spolks_lib/Constants.rb'

class XTcpSocket < BasicSocket
  attr_accessor :client_socket, :socket
  def initialize(host_name, port_number)
    create_socket(host_name, port_number)
  end
  def create_socket(host_name, port_number)
    @socket = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
    @socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, true)
    @sockaddr = Socket.sockaddr_in(port_number, host_name)
  end
  def bind
    @socket.bind(@sockaddr)
    @socket.listen(Constants::BACKLOG_VALUE)
  end
  def listen
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

class XUdpSocket < XBasicSocket
  attr_accessor :socket, :client_sockaddr
  def initialize(host_name, port_number)
    @socket = Socket.new(Socket::AF_INET6, Socket::SOCK_DGRAM, 0)
    @socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, true)
    @sockaddr = Socket.sockaddr_in(port_number, host_name)
  end
  def bind
    @socket.bind(@sockaddr)
  end
  def listen
    self.accept
  end
  def accept
    while(1)
      msg, @client_sockaddr = @socket.recvfrom(1)
      if (msg == '#')
        break
      end
    end
  end
  def send(msg, flags, dst_addr)
    @socket.send(msg, flags, dst_addr)
  end
  def connect(sockaddr)
    @socket.connect(sockaddr)
  end
  def close
    @socket.close
  end
end