require 'init'
class TestRequest < Minitest::Test
  include Quovo::Request

  class RealRequest
    include Quovo::Request
  end

  def http_transport(host = nil, port = nil)
    @fake_http ||= FakeHttp.new
  end

  def setup
    Quovo.real!
    Quovo.config.debug = false
  end

  def teardown
    Quovo.fake!([])
  end

  def test_real_request_transport
    uri = URI(Quovo.config.endpoint)
    assert_instance_of(Net::HTTP, RealRequest.new.http_transport(uri.host, uri.port))
  end

  def test_request_plain
    http_transport.code = '200'
    [:get, :post, :put, :delete].each do |method|
      body = method.to_s
      http_transport.body = body
      result = request(method, '/accounts', {})
      assert_equal(body, result)
    end
  end

  def test_request_json
    http_transport.code = '200'
    [:get, :post, :put, :delete].each do |method|
      body = { "method" => method.to_s }
      http_transport.body = body.to_json
      result = request(method, '/accounts', {}, :json)
      assert_equal(body, result)
    end
  end

  def test_request_unkwown_method
    assert_raises(Quovo::HttpError) do
      request(:path, '/accounts', {})
    end
  end

  def test_request_timeout
    http_transport.timeout = true
    assert_raises(Quovo::HttpError) do
      request(:get, '/accounts', {})
    end
    http_transport.timeout = false
  end

  def test_request_forbidden
    http_transport.code = '403'
    assert_raises(Quovo::ForbiddenError) do
      request(:get, '/accounts', {})
    end
  end

  def test_request_not_found
    http_transport.code = '404'
    assert_raises(Quovo::NotFoundError) do
      request(:get, '/accounts', {})
    end
  end

  def test_request_server_error
    http_transport.code = '500'
    assert_raises(Quovo::HttpError) do
      request(:get, '/accounts', {})
    end
  end

  class FakeHttp
    attr_accessor :read_timeout, :use_ssl, :verify_mode, :body, :code, :timeout

    def start
      yield(self)
    end


    def request(method)
      raise Timeout::Error.new if timeout
      self
    end
  end
end
