module Quovo
  class Token
    using Quovo::Refinements::ToTime
    include Quovo::Request

    def initialize(storage:  Quovo.config.token_storage,
                   ttl:      Quovo.config.token_ttl, 
                   prefix:   Quovo.config.token_prefix, 
                   username: Quovo.config.username, 
                   password: Quovo.config.password
                  )
      @storage  = storage
      @ttl      = ttl
      @prefix   = prefix
      @username = username
      @password = password
    end

    def get
      token, expires = read_cache
      if token.nil? || expires < now
        token, expires = generate
        write_cache(token, expires)
      end
      return token
    end

    def generate
      expires = (now + ttl).iso8601
      salt = ('a'..'z').to_a.shuffle[0,10].join
      params = {
        name: [prefix, expires, salt].join('---'),
        expires: expires
      }
      response = request(:post, '/tokens', params, :json) do |req|
        req.basic_auth(username, password)
      end
      payload = response.fetch('access_token')
      return payload.fetch('token'), payload.fetch('expires').to_time.utc
    end

    private
    attr_reader :storage, :ttl, :prefix, :username, :password

    STORAGE_KEY = 'quovo-access-token'
    SPLITTER = '|'

    def now
      Time.now.utc
    end

    def read_cache
      return @token, @expires if @token && @expires
      token, expires = (storage.read(STORAGE_KEY) || '').split(SPLITTER)
      return nil unless expires
      @token, @expires = token, expires.to_time.utc
      return @token, @expires
    end

    def write_cache(token, expires)
      storage.write(STORAGE_KEY, [token, expires.utc.iso8601].join(SPLITTER))
      @token, @date = token, expires
    end
  end
end
