require "net/http"
require "uri"
require "json"

module PhantIO
	class HTTP
		def self.request(url, path, fields, type = :get, initheader = nil)
      		uri = URI(URI.join(url, path))

      		puts "Performing REST call: #{uri}"
			puts uri.inspect
			http = Net::HTTP.new(uri.host, uri.port)
			http.set_debug_output($stdout)

			if uri.scheme == "https"
				http.use_ssl = true
			end

			if type == :get

				uri.query = URI.encode_www_form(fields)
				req = Net::HTTP::Get.new(uri, initheader)
				puts uri
			else 
				req = Net::HTTP::Post.new(uri, initheader)
				#req.body = fields.to_json
				req.set_form_data(fields)
				puts req
			end

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