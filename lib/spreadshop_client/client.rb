require "net/http"
require "uri"
require "json"

module SpreadshopClient
  class Client
    API_ENDPOINT = "https://api.spreadshop.com/v1/graphql"

    def self.query(query_string, variables = {})
      uri = URI.parse(API_ENDPOINT)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == "https"

      request = Net::HTTP::Post.new(uri.path, {"Content-Type" => "application/json"})
      request.body = {query: query_string.strip, variables: variables}.to_json

      response = http.request(request)
      JSON.parse(response.body)
    rescue => e
      {error: e.message}
    end
  end
end
