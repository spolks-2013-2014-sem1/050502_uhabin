require '../spolks_lib/Sockets.rb'
require '../spolks_lib/Constants.rb'

class TcpServer
  def initialize(socket, filepath)
    @socket = socket
    @file = File.open(filepath, 'rb')
    @oob_data = 0
    @send_data = 0
  end
  def start
    @socket.bind
    @socket.listen
    self.send_file
  end
  def send_file
    while (chunk = @file.read(Constants::CHUNK_SIZE))
      @socket.client_socket.send(chunk, 0)
      sleep(Constants::DELAY_BETWEEN_CHUNKS)
      self.get_data_info(chunk)
    end
  end
  def get_data_info(chunk)
    @oob_data += 1
    STDOUT.puts @send_data
    self.send_oob_data
    @send_data += chunk.length
  end
  def send_oob_data
    if @oob_data % 32 == 0
      @oob_data = 0
      STDOUT.puts "OOB sended"
      @socket.client_socket.send('&', Socket::MSG_OOB)
    end
  end
  def stop
    @socket.close
    @file.close
  end
end