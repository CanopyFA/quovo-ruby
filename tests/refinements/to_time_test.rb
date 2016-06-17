require 'init'
class TestToTime < Minitest::Test
  using Quovo::Refinements::ToTime

  def test_to_time_nil
    actual = nil.to_time
    assert_nil(actual)
  end

  def test_to_time_ok
    str = '2015-05-05'
    actual = str.to_time
    assert_equal(Time.parse(str), actual)
  end

  def test_to_time_raise_error
    assert_raises do
      Struct.new(:a).new(10).to_time
    end
  end
end
