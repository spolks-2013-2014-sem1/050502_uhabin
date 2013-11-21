require 'socket'

class BasicSocket
  def inspect_client (addrinfo)
    print('Client info: ')
    Socket.getnameinfo(addrinfo).each { |line| print(line + ' ') }
    puts('')
  end
end