require 'init'
class TestScope < Minitest::Test
  def test_simple_scope
    Quovo.scope(foo: 'bar') do
      assert_equal(Quovo.current_scope[:foo], 'bar')
    end
  end

  def test_nested_scope
    Quovo.scope(foo: 1) do
      Quovo.scope(foo: 2) do
        assert_equal(Quovo.current_scope[:foo], 2)
      end
      assert_equal(Quovo.current_scope[:foo], 1)
    end

    Quovo.scope(foo: 1) do
      Quovo.scope(bar: 2) do
        assert_equal(Quovo.current_scope, foo: 1, bar: 2)
      end
    end
  end
end
