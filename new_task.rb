require_relative "bunny_broker_connection"

class NewTask < BunnyBrokerConnection

  def initialize; super; end

  def call(msg)
    puts "[x] Sending message #{msg} - START"
    queue.publish(msg, persistent: true)
    puts "[x] Sending message #{msg} - DONE"
    close_connection
  rescue Interrupt => _
    close_connection
  end
end


msg = ARGV.empty? ? "Hello World!" : ARGV.join(" ")
NewTask.new.call(msg)
