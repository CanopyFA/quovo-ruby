module Quovo
  class Config
    attr_accessor :username
    attr_accessor :password
    attr_accessor :token_ttl       # seconds
    attr_accessor :request_timeout # seconds
    attr_accessor :token_prefix    
    attr_accessor :token_storage
    attr_accessor :debug
    attr_accessor :strip_sensitive_params

    DEFAULT_ENDPOINT = 'https://api.quovo.com/v2'


    def initialize
      @username               = nil
      @password               = nil
      @token_ttl              = 60 * 60
      @request_timeout        = 60
      @token_prefix           = 'QUOVO-ACCESS-TOKEN'
      @token_storage          = default_memory_storage
      @debug                  = false
      @strip_sensitive_params = true
    end

    def endpoint
      DEFAULT_ENDPOINT
    end

    def [](option)
      send(option)
    end

    def self.configurator
      @conf_mod ||= Module.new do
        def configure
          yield(config)
        end

        def config
          @config ||= Config.new
        end
      end
    end

    def default_memory_storage
      Object.new.tap do |o|
        def o.storage
          @storage ||= {}
        end

        def o.read(key)
          self.storage[key]
        end

        def o.write(key, value)
          self.storage[key] = value
        end
      end
    end
  end
end