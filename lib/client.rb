require 'socket'

class Client
  DEBUG_OUTPUT = true

  def initialize(host, port)
    @s = TCPSocket.open(host, port)
  end

  def request(payload)
    @s.print(payload)

    raw = []
    while line = @s.gets
      puts "DEBUG: " + line if DEBUG_OUTPUT
      raw.push line
    end
    @s.close

    response = {}
    response = Balance.from_string raw.shift

    response[:transactions] = []
    raw.each { |txt|
      response[:transactions].push Transaction.from_string txt
    }

    response
  end
end
