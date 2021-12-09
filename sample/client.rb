#!/usr/bin/env ruby
$:.unshift File.expand_path '../lib', File.dirname(__FILE__)
require 'rubygems'
require 'websocket-client-simple'

puts "websocket-client-simple v#{WebSocket::Client::Simple::VERSION}"

url = ARGV.shift || 'ws://localhost:8080'

ws = WebSocket::Client::Simple.connect url do |client|

  client.on :message do |msg|
    puts ">> #{msg.data}"
  end

  client.on :open do
    puts "-- websocket open (#{client.url})"
  end

  client.on :close do |e|
    puts "-- websocket close (#{e.inspect})"
    exit 1
  end

  client.on :error do |e|
    puts "-- error (#{e.inspect})"
  end

end

loop do
  ws.send STDIN.gets.strip
end
