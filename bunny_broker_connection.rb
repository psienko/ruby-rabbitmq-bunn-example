require "bunny"

class BunnyBrokerConnection
  QUEUE_NAME = "hello"

  def connection 
    return @connection if @connection
    @connection = Bunny.new
    @connection.start
    @connection
  end

  def channel
    @channel ||= connection.create_channel
  end

  def queue
    @queue ||= channel.queue(QUEUE_NAME)
  end

  def close_connection
    connection.close
    puts "[x] Connection closed"
  end
end
