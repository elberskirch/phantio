require "cgi"

module PhantIO
	class Stream
		def initialize(public_key, options = {})
			@public_key = public_key
			@private_key = options["private_key"] || nil
			@delete_key = options["delete_key"] || nil
			@url = options["url"] || DEFAULT_SERVER
		end

		def input(fields = {})
			raise StandardError if @private_key == nil

			resource = build_resource(:input)
			params = fields
			fields["private_key"] = @private_key
			Http.request(@url, resource, params)
		end

		private
		def build_resource(type)
			case type
			when :input
				url = "/input/" + @public_key 
			end
			url
		end
	end
end