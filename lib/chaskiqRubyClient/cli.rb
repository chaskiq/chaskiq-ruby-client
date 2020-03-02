require "pry"
module ChaskiqRubyClient

  class Cli < Thor

    no_tasks {}

    desc "hello NAME", "say hello to NAME"
    def hello(name, from=nil)
      puts "from: #{from}" if from
      puts "Hello #{name}"
    end

    #{
    #  uid: "h9CgouFY427ylil9EK2iLolKQZMeZVi96pTv0Q7dNhE",
    #  secret: "E2X7QNN2sob5xZdjQ48ukn688b5nskUHi5vgEuAetew",
    #  site: "http://app.chaskiq.test:3000"
    #}

    ## bundle exec ./bin/chaskiq auth_url --uid=h9CgouFY427ylil9EK2iLolKQZMeZVi96pTv0Q7dNhE --secret=E2X7QNN2sob5xZdjQ48ukn688b5nskUHi5vgEuAetew --site=http://app.chaskiq.test:3000

    desc "auth_url CODE", "code auth"
    method_option :uid, :aliases => "-u", :desc => "client id"
    method_option :site, :aliases => "-h", :desc => "client site"
    method_option :secret, :aliases => "-h", :desc => "client secret"
    def auth_url
      auth = ChaskiqRubyClient::Auth
      uid = options[:uid] || ask("enter client_id:")
      site = options[:site] || ask("enter site:")
      secret = options[:secret] || ask("enter secret:")
      auth_client = auth.new(uid: uid, secret: secret, site: site)
      uri = auth_client.authorize_url
      puts uri
    end

    desc "apps", "apps list"
    def apps
      token = "LbB8IVh6DvSj7m5xJ93VfQcyxE954I5KxqrKg2m4BVg"
      subject = ChaskiqRubyClient::Client.new("http://app.chaskiq.test:3000/graphql", token)
      q = <<-'GRAPHQL'
        query {
          apps {
            name
          }
        }
      GRAPHQL

      #q = subject.client.query{ query{ apps{ name } } }

      result = subject.query(q)

      puts result.data.to_h
    end


    desc "campaign", "apps list"
    method_option :auth_token, :aliases => "-t", :desc => "token"
    method_option :app_key, :aliases => "-k", :desc => "app key"
    method_option :id, :aliases => "-i", :desc => "client secret"
    method_option :page, :aliases => "-p", :desc => "page"
    def campaign

      token = options[:auth_token] || ask("enter auth_token:") #"Tro6BMCnPJ7yxedLJ8EgaVAMrFBWK1yXg01tacbCKWE"
      key   = options[:app_key] || ask("enter app_key:")
      id    = options[:id] || ask("enter id:")
      page  = options[:page] || ask("enter page:")

      subject = ChaskiqRubyClient::Client.new(
        "https://app.chaskiq.io/graphql", 
        token
      )

      result = subject.client.query{ 
        query {
          app(key: key ) {
            botTask(id: id.to_s ){
              id
              counts
              statsFields
              metrics(page: page.to_i, per: 100){
                collection {
                  action
                  host
                  data
                  messageId
                  email
                  appUserId
                  updatedAt
                  createdAt
                }
                meta
              }
            }
          }
        }
      }

      puts result.data.to_h.to_json
    end


    desc "conversation", "conversation"
    method_option :auth_token, :aliases => "-t", :desc => "token"
    method_option :app_key, :aliases => "-k", :desc => "app key"
    method_option :id, :aliases => "-i", :desc => "client secret"
    method_option :page, :aliases => "-p", :desc => "page"
    def conversation

      token = options[:auth_token] || ask("enter auth_token:") #"Tro6BMCnPJ7yxedLJ8EgaVAMrFBWK1yXg01tacbCKWE"
      key   = options[:app_key] || ask("enter app_key:")
      id    = options[:id] || ask("enter id:")
      page  = options[:page] || ask("enter page:")

      subject = ChaskiqRubyClient::Client.new(
        "https://app.chaskiq.io/graphql", 
        token
      )

      result = subject.client.query{
        query{
          app(key: key) {
            encryptionKey
            key
            name
            conversation(id: id.to_s){
              id
              key
              state
              readAt
              priority
              assignee {
                id
                email
                avatarUrl
              }
              mainParticipant{
                id
                email
                avatarUrl
                properties
                displayName
              }
              
              messages(page: page.to_i){
                collection{
                  id
                  stepId
                  triggerId
                  fromBot
                  message{
                    blocks
                    data
                    state
                    htmlContent
                    textContent
                    serializedContent
                    action
                  }
                  source
                  readAt
                  createdAt
                  privateNote
                  appUser{
                    id
                    email
                    avatarUrl
                    kind
                    displayName
                  }
                  source
                  messageSource {
                    name
                    state
                    fromName
                    fromEmail
                    serializedContent
                  }
                  emailMessageId
                }
                meta
              }
            }
          }
        }
      }

      puts result.data.to_h.to_json
    end

    


  end

end