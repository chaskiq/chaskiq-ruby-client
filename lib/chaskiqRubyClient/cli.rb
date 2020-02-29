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
      subject = ChaskiqRubyClient::Client.new("http://localhost:3000/graphql", token)
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


  end

end