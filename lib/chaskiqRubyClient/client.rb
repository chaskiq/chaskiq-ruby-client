require "Graphlient"

module ChaskiqRubyClient

  class Client

    attr_accessor :size, :client, :schema, :token

    def initialize(site, token)
      
      self.token = token

      @client = Graphlient::Client.new(site,
        headers: {"Authorization" => "Bearer #{token}"},
        http_options: {
          read_timeout: 20,
          write_timeout: 30
        }
      )
    end

    def query(q, variables={})
      client.query(q, variables)
    end
  end
end