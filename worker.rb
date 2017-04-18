#!/usr/bin/env ruby
# encoding: utf-8

require_relative "bunny_broker_connection"

class Worker < BunnyBrokerConnection

  def initialzie; super; end

  def call
    wait_for_message
  rescue Interrupt => _
    close_connection
  end

  private

  def wait_for_message
    puts " [*] Waiting for messages in #{queue.name}. To exit press CTRL+C"
    queue.subscribe(manual_ack: true, block: true) do |delivery_info, properties, body|
      puts " [>x] Received #{body}"
      sleep body.count('.').to_i
      puts " [x<] Done"
      channel.ack(delivery_info.delivery_tag)
    end
  end
end

Worker.new.call
