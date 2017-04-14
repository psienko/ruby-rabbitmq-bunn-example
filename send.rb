#!/usr/bin/env ruby
# encoding: utf-8

require_relative "bunny_broker_connection"

class Sender < BunnyBrokerConnection
 
  def call
    puts "[x] Sending message to queue - START"
    channel.default_exchange.publish("Hello World!", routing_key: queue.name)
    puts "[x] Sending message to queue - DONE"
    close_connection
  end
end

Sender.new.call

