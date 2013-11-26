require 'socket'

class BasicSocket
  def inspect_client (addrinfo)
    fd = IO.sysopen "/dev/tty", "w"
    ios = IO.new(fd, "w")
    ios.print 'Client info:'
    Socket.getnameinfo(addrinfo).each { |line| ios.print(line + ' ') }
    ios.puts
  end
end