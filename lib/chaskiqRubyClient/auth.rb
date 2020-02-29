require "oauth2"

module ChaskiqRubyClient

  class Auth

    attr_accessor :uid, :secret, :site

    def initialize(uid:, secret:, site:)
      self.uid = uid
      self.secret = secret
      self.site = site
    end

    def get_token(user, password)
      client = OAuth2::Client.new(uid, secret, site: site)
      access_token =  client.password.get_token(
        user, 
        password
      ).token
    end

    def authorize_url
      client = OAuth2::Client.new(uid, secret, site: site)
      client.authorize_url(
        redirect_uri: site , 
        client_id: uid,
        response_type: "code"
      )
    end

  end

end