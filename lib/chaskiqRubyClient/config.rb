require "active_support"

module ChaskiqRubyClient

  class Config

    mattr_accessor  :secret_key
    
    def self.setup
      yield self
    end

    def self.configure!
      begin
      #we will rescue this in order to allow rails g chaskiq:install works
      rescue Chaskiq::ConfigError => e
        puts e
        puts e.message
      end
    end

  end

  class ConfigError < StandardError
    attr_reader :object
    def initialize(key)
      @key = key
    end

    def message
      "\033[31m #{@key} config key not found, add it in Chaskiq::Config.setup initializer \033[0m"
    end

  end

end