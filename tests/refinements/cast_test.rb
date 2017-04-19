require 'init'
class TestCast < Minitest::Test
  using Quovo::Refinements::Cast

  class Foo < Quovo::Models::Base
    fields %i(a b)
  end

  def test_cast_nil
    actual = nil.cast(Foo)
    assert_nil(actual)
  end

  def test_cast_obj
    expected = { a: 1, b: 2 }
    actual = expected.cast(Foo)
    assert_instance_of(Foo, actual)
    assert_equal(expected, actual.to_h)
  end

  def test_cast_array
    expected = [{ a: 1, b: 2 }]
    actual = expected.cast(Foo)
    assert_equal(actual.length, 1)
    assert_instance_of(Foo, actual[0])
    assert_equal(expected[0], actual[0].to_h)
  end

  def test_cast_unknown
    test = 'test'
    assert_raises do
      test.cast(Foo)
    end
    test = 1
    assert_raises do
      test.cast(Foo)
    end
    test = Struct.new(:a).new(1)
    assert_raises do
      test.cast(Foo)
    end
  end
end
