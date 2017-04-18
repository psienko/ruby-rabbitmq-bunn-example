require "bunny"

class BunnyBrokerConnection
  QUEUE_NAME = "task_queue"
  PREFETCH_LIMIT = 1

  def initialize
    limit_channel_prefetch(1)
  end

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
    @queue ||= channel.queue(QUEUE_NAME, durable: true)
  end

  def close_connection
    connection.close
    puts "[x] Connection closed"
  end

  def limit_channel_prefetch(limit)
    channel.prefetch(limit)
  end
end
