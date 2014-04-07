# # -*- coding: utf-8 -*-
# require "rubygems"
# require "net/http"
# require "net/https"
# require "uri"

# # uri = URI.parse("http://google.com/")
# # # response = Net::HTTP.get_response(uri)
# # # Net::HTTP.get_print(uri)
# # # puts response.body

# # http = Net::HTTP.new(uri.host, uri.port)
# # puts "the uri.request_uri is: #{uri.request_uri} \n"
# # puts "the uri.host is: #{uri.host} \n"
# # puts "the uri.port is: #{uri.port} \n"

# # req = Net::HTTP::Get.new(uri.request_uri)
# # puts "the req.body is: #{req.body}\n"
# # response = http.request(req)  
# # puts "the response body is: #{response.body}\n"

# # uri = URI.parse("http://google.com/")
# # http = Net::HTTP.new(uri.host, uri.port)
# # req = Net::HTTP::Get.new(uri.request_uri)
# # req.basic_auth("username","password")
# # resp = http.request(req)
# # puts "with basic.auth, resp is: #{resp.body}"


# uri = URI.parse("https://localhost:4001")




# # Shortcut
# response = Net::HTTP.post_form(uri, {"q" => "My query", "per_page" => "50"})

# # Full control
# http = Net::HTTP.new(uri.host, uri.port)

# request = Net::HTTP::Post.new(uri.request_uri)
# request.set_form_data({"q" => "My query", "per_page" => "50"})
# request.use_ssl=true
# request.ssl_version="SSLv3"

# response = http.request(request)

# puts "the response is: #{response}"
# puts "the response.body is: #{response.body}"

# # uri = URI.parse("http://google.com/")

# # http = Net::HTTP.new(uri.host, uri.port)
# # request = Net::HTTP::Get.new(uri.request_uri)
# # request.basic_auth("username", "password")
# # response = http.request(request)

require "net/https"
require "uri"

uri = URI.parse("https://localhost:4001")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)
response.body
response.status
response["header-here"] # All headers are lowercase
