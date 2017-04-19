module Quovo
  module Request
    using Quovo::Refinements::Sensitive

    def request(method, path, params = {}, format = :plain, config = Quovo.config)
      return fake_request(method, path, params, &Proc.new) if Quovo.fake?

      uri = build_uri(config.endpoint, method, path, params)
      request = build_http_request(uri, method, params)

      yield(request) if block_given?

      do_http_request(request, config.request_timeout, format) do |status_code, payload, elapsed|
        Quovo.run_hooks!(
          path,
          method.to_s.upcase,
          strip_sensitive(params, config),
          status_code,
          strip_sensitive(payload, config),
          elapsed
        )
        payload
      end
    end

    protected

    def build_uri(endpoint, method, path, params)
      get_params = '?' + URI.encode_www_form(params) if method == :get && params.any?
      URI(endpoint + path + (get_params || ''))
    end

    def build_http_request(uri, method, params)
      raise Quovo::HttpError, 'unsupported method' unless %i(get post put delete).include?(method)
      request = Kernel.const_get("Net::HTTP::#{method.to_s.capitalize}").new(uri)
      inject_http_params(request, params) if method != :get && params.any?
      request
    end

    def http_transport(uri)
      Net::HTTP.new(uri.host, uri.port)
    end

    private

    def do_http_request(request, timeout, format)
      http              = http_transport(request.uri)
      http.read_timeout = timeout
      http.use_ssl      = true
      http.verify_mode  = OpenSSL::SSL::VERIFY_NONE

      http.start do |transport|
        (status_code, payload), elapsed = with_timing { parse_http_response(transport.request(request), format) }
        yield(status_code, payload, elapsed)
      end
    end

    def inject_http_params(request, params)
      request.body = params.to_json
      request['Content-Type'] = 'application/json'
    end

    def parse_http_response(response, format)
      status_code = response.code
      body        = response.body
      raise Quovo::NotFoundError,  body if status_code =~ /404/
      raise Quovo::ForbiddenError, body if status_code =~ /403/
      raise Quovo::HttpError,      body if status_code =~ /^[45]/
      payload = format == :json ? JSON.parse(body) : body
      [status_code, payload]
    end

    def with_timing
      start_at = Time.now
      result   = yield
      elapsed  = (Time.now - start_at).round(3)
      [result, elapsed]
    end

    def strip_sensitive(data, config)
      config.strip_sensitive_params ? data.strip_sensitive : data
    end

    class FakeRequest
      attr_reader :username, :password
      def basic_auth(username, password)
        @username = username
        @password = password
      end

      def []=(_, __)
        {}
      end
    end

    def fake_request(method, path, params)
      fake = Quovo.fake_calls.find do |fake_method, fake_path, fake_params, _|
        fake_method == method && fake_path == path && (fake_params == params || fake_params == '*')
      end
      raise StubNotFoundError, [method, path, params] unless fake
      yield(FakeRequest.new) if block_given?
      fake.last
    end
  end
end
