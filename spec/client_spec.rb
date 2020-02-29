
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

    it "will setup & query" do
      
      VCR.use_cassette("query_apps_collection") do
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
    end


    it "mutation" do
      VCR.use_cassette("mutation_invite_agent") do
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
end