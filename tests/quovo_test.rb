require 'init'
class TestQuovo < Minitest::Test
  def test_inspect
    assert_equal(Quovo.inspect, Quovo.config.inspect)
  end
end
