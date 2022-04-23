require 'socket'

def roll_dice(num, sides)
  sum = 0
  num.times do |_|
    sum += rand(sides) + 1
  end
  sum
end

def parse_request(request_line)
  http_method, path_and_param, http_version = request_line.split(' ')
  path, params = path_and_param.split('?')
  params = (params || "").split('&').each_with_object({}) do |param, hash|
    key, value = param.split('=')
    hash[key] = value
  end
  [http_method, path, params]
end

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept

  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  next unless request_line

  http_method, path, params = parse_request(request_line)

  puts request_line
  puts http_method
  puts path
  p params

  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html\r\n\r\n"
  client.puts request_line
  number = params['number'].to_i
  client.puts "<html>"
  client.puts "<body>"
  client.puts "<p>current number is #{number}.</p>"
  client.puts "<a href='?number=#{number + 1}'>Add one</a>"
  client.puts "</body>"
  client.puts "</html>"
  client.close
end