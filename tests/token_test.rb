require 'init'
class TestToken < Minitest::Test
  class Storage
    def initialize
      @read = false
      @write = false
    end

    def read?; !!@read; end
    def write?; !!@write; end

    def read(key)
      @read = true
      ["token", Time.now.utc.iso8601].join('|')
    end

    def write(key, token)
      @write = true
    end
  end

  def setup
    Quovo.fake!([
      [:post, "/tokens", 
       '*',
       {'access_token' => {'token' => 'TOKEN', 'expires' =>'2016-01-01T12:00:00Z'}}]
    ])
  end

  def test_token_uses_storage
    storage = Storage.new
    token = Quovo::Token.new(storage: storage)
    assert_equal(storage.read?, false)
    assert_equal(storage.write?, false)
    token.get
    assert_equal(storage.read?, true)
    assert_equal(storage.write?, true)
  end
end
