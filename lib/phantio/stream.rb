require "cgi"

module PhantIO
	class Stream
		def initialize(options = {})
			@public_key = options["public_key"] || nil
			@private_key = options["private_key"] || nil
			@delete_key = options["delete_key"] || nil
			@url = options[:url] || DEFAULT_SERVER
		end

		def input(fields = {})
			raise StandardError if @private_key == nil

			resource = build_resource(:input)
			params = fields
			fields["private_key"] = @private_key
			response = HTTP.request(@url, resource, params)
			response.body
		end

		def create(options = {:title => "stream", :description => "My Stream", :fields => "temp1,temp2"})
			resource = build_resource(:create)
			response = HTTP.request(@url, resource, options, :post, {'Accept'=>'application/json'})
			response.body
		end

		private
		def build_resource(type)
			case type
			when :input
				url = "/input/" + @public_key 
			when :create
				url = "/streams/"
			end
			url
		end
	end
end