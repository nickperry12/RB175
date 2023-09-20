require 'socket'
require 'pry'

def parse_request_line(request_line)
  http_method, path_and_params, http_version = request_line.split(' ')
  path, params = path_and_params.split('?')

  params = (params || "").split('&').each_with_object({}) do |str, hsh|
    key, val = str.split('=')
    hsh[key] = val
  end

  [http_method, params, http_version, path]
end

server = TCPServer.new("localhost", 3003)

loop do
  client = server.accept

  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  puts request_line 

  http_method, params, http_version, path = parse_request_line(request_line)

  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html\r\n\r\n"
  client.puts"<html>"
  client.puts "<body>"
  client.puts "<pre>"
  client.puts http_method
  client.puts path
  client.puts params
  client.puts "</pre>"

  client.puts "<h1>Counter</h1>"
  number = params["number"].to_i
  client.puts "<p>The current number is <strong>#{number}</strong>.</p>"

  client.puts "<a href='?number=#{number + 1}'>Add one</a>"
  client.puts "<a href='?number=#{number - 1}'>Subtract one</a>"
  client.puts "</body>"
  client.puts "</html>"

  client.close
end