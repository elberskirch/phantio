require "net/http"
require "uri"

module PhantIO
	class Http
		def self.request(url, path, fields, options = {})
      		uri = URI(URI.join(url, path))
      		puts "Performing REST call: #{uri}"
      		uri.query = URI.encode_www_form(fields)

			puts uri.inspect
			http = Net::HTTP.new(uri.host, uri.port)
			http.set_debug_output($stdout)
			http.use_ssl = true
			req = Net::HTTP::Get.new(uri)
			puts uri
			begin
				res = http.request(req)
			rescue SocketError => se
				puts "Caught a SocketError #{se}"
				puts "Seems like you're not connected to a network"
				exit
			end
			puts res.body.inspect
			res
		end


	end
end