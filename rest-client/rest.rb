require 'rest-client'

class BingSearch
	attr_reader :root, :response
	def initialize(query='')
		@root = "https://www.bing.com/search?q="
		@response = search(query)
	end

	def search(query)
		RestClient.get @root + query
	end

	def get_code
		@response.code
	end

	def get_cookies
		@response.cookies
	end

	def get_headers
		@response.headers
	end

	def get_body
		@response.body
	end
end