require 'gqli'
require "graphql/client"
require "graphql/client/http"

module ChaskiqRubyClient
  class Client

    attr_accessor :size, :client, :schema, :token

    def initialize(site, token)
      
      self.token = token

      # Configure GraphQL endpoint using the basic HTTP network adapter.
      http = GraphQL::Client::HTTP.new(site) do
        def headers(context)
          # Optionally set any HTTP headers
          #{ "User-Agent": "My Client" }
          {"Authorization" => "Bearer #{context[:token]}"}
        end
      end  
    
      # Fetch latest schema on init, this will make a network request
      @schema = GraphQL::Client.load_schema( 
        GraphQL::Client.dump_schema(
          http, 
          nil, 
          context: { token: token }
        ) 
      )
    
      # However, it's smart to dump this to a JSON file and load from disk
      #
      # Run it from a script or rake task
      #   GraphQL::Client.dump_schema(SWAPI::HTTP, "path/to/schema.json")
      #
      # Schema = GraphQL::Client.load_schema("path/to/schema.json")
    
      @client = GraphQL::Client.new(
        schema: @schema, 
        execute: http
      )
    end

    def query(type, variables={})
      self.client.query( type, {
        context: {
          token: self.token
        },
        variables: variables
      })
    end
  end
end