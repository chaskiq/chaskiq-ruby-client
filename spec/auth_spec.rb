
require "spec_helper"
require "oauth2"

module ChaskiqRubyClient

  RSpec.describe ChaskiqRubyClient::Client, type: :model do

    let(:auth){  ChaskiqRubyClient::Auth }

    let(:credentials) {
      {
        uid: "h9CgouFY427ylil9EK2iLolKQZMeZVi96pTv0Q7dNhE",
        secret: "E2X7QNN2sob5xZdjQ48ukn688b5nskUHi5vgEuAetew",
        site: "http://app.chaskiq.test:3000"
      }
    }
    
    it "auth code token" do
      VCR.use_cassette("auth_code") do
        uid, secret, site = credentials.values
        auth_client = auth.new(uid:uid, secret: secret, site: site)
        token = auth_client.get_token(
          "admin@test.com", 
          "123456"
        )
        expect(token).to_not be_nil
      end
    end

    it "redirect uri" do
      uid, secret, site = credentials.values
      auth_client = auth.new(uid:uid, secret: secret, site: site)
      uri = auth_client.authorize_url
      expect(uri).to_not be_nil
    end

  end
end