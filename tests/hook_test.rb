require 'init'
class TestHook < Minitest::Test
  def setup
    Quovo.clear_hooks!
  end

  def test_simple_hook
    hooked = false
    Quovo.hook do |*agrs|
      hooked = true
    end
    assert_equal(Quovo.hooks.length, 1)
    assert_equal(hooked, false)
    Quovo.run_hooks!
    assert_equal(hooked, true)
  end

  def test_clear_all_hooks
    Quovo.hook do |*agrs|
    end
    assert_equal(Quovo.hooks.length, 1)
    Quovo.clear_hooks!
    assert_equal(Quovo.hooks.length, 0)
  end

  def test_logging
    assert_equal(Quovo.hooks.length, 0)
    Quovo.enable_logging
    Quovo.config.debug = true
    assert_output(/path/) do
      Quovo.run_hooks!('path', 'method', 'params', 'status', 'response', 'elapsed_time')
    end
    assert_equal(Quovo.hooks.length, 1)
  end
end

