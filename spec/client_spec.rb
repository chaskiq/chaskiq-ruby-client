
require "spec_helper"
require "oauth2"

module ChaskiqRubyClient

  RSpec.describe ChaskiqRubyClient::Client, type: :model do

    let(:client){  ChaskiqRubyClient::Client }
    let(:token) {
      "LbB8IVh6DvSj7m5xJ93VfQcyxE954I5KxqrKg2m4BVg"
    }

    subject{
      client.new("http://localhost:3000/graphql", token)
    }


    it "token" do
      uid = "h9CgouFY427ylil9EK2iLolKQZMeZVi96pTv0Q7dNhE"
      secret = "E2X7QNN2sob5xZdjQ48ukn688b5nskUHi5vgEuAetew"
      site = "http://app.chaskiq.test:3000"

      client = OAuth2::Client.new(uid, secret, site: site)

      
      access_token =  client.password.get_token(
        "admin@test.com", 
        "123456"
      )

      puts access_token.token
      expect(access_token.token).to_not be_nil
    end

    it "will setup & query" do
      
      Apps = subject.client.parse <<-'GRAPHQL'
        query {
          apps {
            name
          }
        }
      GRAPHQL

      result = subject.query(Apps)
      expect(result.data.apps.size).to be > 0
    end


    it "mutation" do
      InviteAgent = subject.client.parse <<-'GRAPHQL'
        mutation($appKey: String!, $email: String!){
          inviteAgent(appKey: $appKey, email: $email){
            agent {
              email
              avatarUrl
              name
            }
          }
        }
      GRAPHQL


      result = subject.query(InviteAgent, {
        email: "foo@bar.com",
        appKey: "3v1y3UejFtX1itkssgdi-A",
      })

      expect(result.data.invite_agent.agent.email).to be == "foo@bar.com"

    end

  end
end