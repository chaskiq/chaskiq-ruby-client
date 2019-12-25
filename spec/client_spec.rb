
require "spec_helper"

module ChaskiqRubyClient

  RSpec.describe ChaskiqRubyClient::Client, type: :model do

    let(:client){  ChaskiqRubyClient::Client }
    let(:token) {
      "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiI3MzZlMGVkOS05NjBmLTQxMmEtYThhMC1lYjI3YTEwMTdmOWQiLCJzdWIiOiIxIiwic2NwIjoiYWdlbnQiLCJhdWQiOm51bGwsImlhdCI6MTU3NzE5NzczOSwiZXhwIjoxNTc3Mjg0MTM5fQ.2zF_4jNENl1cP1Zk9t_fjycnxOUdjI5FJgf19rNv08o"
    }

    subject{
      client.new(token)
    }

    it "will setup & query" do
      
      subject = client.new(token)
      
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
        appKey: "GPi9haWV1ocbr4My_Q8xPw",
      })

      expect(result.data.invite_agent.agent.email).to be == "foo@bar.com"

    end

  end
end