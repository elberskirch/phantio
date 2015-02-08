require "thor"
require "thor/shell/basic"
require "thor/actions"
require "json"
require "phantio"

module PhantIO
	class CLI < Thor
		include Thor::Shell
		include Thor::Actions 

		desc "create", "create a new PhantIO stream"
		def create()
			options = {}
			fields = {}
			options["url"] = ask("PhantIO url: ")
			fields["title"] = ask("PhantIO stream title: ")
			fields["description"] = ask("PhantIO stream description: ")
			fields["fields"] = ask("PhantIO stream fields [e.g. _val1,_val2]: ")

			stream = PhantIO::Stream.new(options)
			stream_json = stream.create(fields)
			stream_hash = JSON.parse(stream_json)
			options.merge!(stream_hash)
			puts options.inspect
			title = options["stream"]["title"]
			title = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
			create_file "#{title}.json", options.to_json
		end
	end
end