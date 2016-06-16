module Quovo
  module Request
    using Quovo::Refinements::Sensitive

    def request(method, path, params = {}, format = :plain, config = Quovo.config, &block)
      return fake_request(method, path, params, &block) if Quovo.fake?

      uri = URI(config.endpoint + path)
      request = case method
                when :get
                  uri.query = URI.encode_www_form(params)  unless params.empty?
                  Net::HTTP::Get
                when :post
                  Net::HTTP::Post
                when :put
                  Net::HTTP::Put
                when :delete
                  Net::HTTP::Delete
                else
                  raise Quovo::HttpError.new('unsupported method')
                end.new(uri)

      unless method == :get
        request.body = params.to_json 
        request['Content-Type'] = 'application/json'
      end

      yield(request) if block_given?

      http = http_transport(uri.host, uri.port)
      http.read_timeout = config.request_timeout
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      begin
        http.start do |channel|
          start_at   = Time.now
          response   = channel.request(request)
          finish_at  = Time.now
          body       = response.body
          code       = response.code
          payload    = format == :json ? JSON.parse(body) : body
          elapsed    = (finish_at - start_at).round(3)
          filtered_params  = config.strip_sensitive_params ? params.strip_sensitive : params
          filtered_payload = config.strip_sensitive_params ? payload.strip_sensitive : payload

          Quovo.run_hooks!(uri.path, method.to_s.upcase, filtered_params, code, filtered_payload, elapsed)

          raise Quovo::NotFoundError.new(body)  if code =~ /404/
          raise Quovo::ForbiddenError.new(body) if code =~ /403/
          raise Quovo::HttpError.new(body)      if code =~ /^[45]/
          payload
        end
      rescue Timeout::Error => e
        raise Quovo::HttpError.new(e)
      end
    end

    def http_transport(host, port)
      Net::HTTP.new(host, port)
    end

    private

    class FakeRequest
      attr_reader :username, :password
      def basic_auth(username, password)
        @username, @password = username, password
      end

      def []=(name, value)
        {}
      end
    end

    def fake_request(method, path, params)
      fake = Quovo.fake_calls.find do |fake_method, fake_path, fake_params, fake_response|
        fake_method == method && fake_path == path && (fake_params == params || fake_params == '*')
      end
      raise StubNotFoundError.new([method, path, params]) unless fake
      yield(FakeRequest.new) if block_given?
      fake.last #response
    end
  end
end
