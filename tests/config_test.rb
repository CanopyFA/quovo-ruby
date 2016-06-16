require 'init'
class TestConfig < Minitest::Test
  def test_default_config
    config = Quovo::Config.new

    assert_nil(config.username)
    assert_nil(config.password)
    assert_equal(config.endpoint               , 'https://api.quovo.com/v2')
    assert_equal(config.token_ttl              , 60 * 60)
    assert_equal(config.request_timeout        , 60)
    assert_equal(config.token_prefix           , 'QUOVO-ACCESS-TOKEN')
    assert_equal(config.debug                  , false)
    assert_equal(config.strip_sensitive_params , true)
  end

  def test_default_storage
    key     = 'test'
    value   = 'value'
    storage = Quovo::Config.new.token_storage

    assert_nil(storage.read(key))
    storage.write(key, value)
    assert_equal(storage.read(key), value)
  end

  def test_change_config
    Quovo.configure do |config|
      config.username               = 'username'
      config.password               = 'password'
      config.token_ttl              = 1000
      config.request_timeout        = 1000
      config.token_prefix           = 'PREFIX'
      config.debug                  = true
      config.strip_sensitive_params = false
      config.token_storage          = nil
    end
    config = Quovo.config
    assert_equal(config.username               , 'username')
    assert_equal(config.password               , 'password')
    assert_equal(config.token_ttl              , 1000)
    assert_equal(config.request_timeout        , 1000)
    assert_equal(config.token_prefix           , 'PREFIX')
    assert_equal(config.debug                  , true)
    assert_equal(config.strip_sensitive_params , false)
    assert_equal(config.token_storage          , nil)

    Quovo.instance_variable_set(:@config, Quovo::Config.new)
  end

  def test_access_by_hash
    config = Quovo::Config.new
    assert_equal(config['strip_sensitive_params'], true)

    assert_raises do
      config['unknown_property']
    end
  end
end
