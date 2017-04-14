#!/usr/bin/env ruby
# encoding: utf-8

require_relative "bunny_broker_connection"

class Receive < BunnyBrokerConnection

  def call
    wait_for_message
  end

  private

  def wait_for_message
    puts " [*] Waiting for messages in #{queue.name}. To exit press CTRL+C"
    queue.subscribe(block: true) do |delivery_info, properties, body|
      puts " [x] Received #{body}"
    end
  end
end

Receive.new.call
