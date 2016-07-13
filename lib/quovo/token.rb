module Quovo
  class Token
    using Quovo::Refinements::ToTime
    include Quovo::Request

    def initialize(storage: Quovo.config.token_storage, ttl: Quovo.config.token_ttl, prefix: Quovo.config.token_prefix, username: Quovo.config.username, password: Quovo.config.password)
      @storage  = storage
      @ttl      = ttl
      @prefix   = prefix
      @username = username
      @password = password
      @token    = nil
      @expires  = nil
    end

    def get
      token, expires = read_cache
      if token.nil? || expires < now
        token, expires = generate
        write_cache(token, expires)
      end
      token
    end

    def generate
      params = {
        name: [prefix, expires_from_now, salt].join('---'),
        expires: expires_from_now
      }
      payload = request(:post, '/tokens', params, :json) do |req|
        req.basic_auth(username, password)
      end.fetch('access_token')
      [payload.fetch('token'), payload.fetch('expires').to_time.utc]
    end

    attr_reader :storage, :ttl, :prefix, :username, :password

    private

    STORAGE_KEY = 'quovo-access-token'.freeze
    SPLITTER = '|'.freeze

    def salt
      ('a'..'z').to_a.sample(10).join
    end

    def now
      Time.now.utc
    end

    def expires_from_now
      (now + ttl).iso8601
    end

    def read_cache
      return @token, @expires if @token && @expires
      token, expires = (storage.read(STORAGE_KEY) || '').split(SPLITTER)
      return nil unless expires
      @token = token
      @expires = expires.to_time.utc
      [@token, @expires]
    end

    def write_cache(token, expires)
      storage.write(STORAGE_KEY, [token, expires.utc.iso8601].join(SPLITTER))
      @token = token
      @expires = expires
    end
  end
end
