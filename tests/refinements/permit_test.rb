require 'init'
class TestPermit < Minitest::Test
  using Quovo::Refinements::Permit

  def test_permit_hash
    actual = { a: 1, b: 2, c: 3 }
    actual.permit!(:a, :c)
    assert_equal({ a: 1, c: 3 }, actual)
  end

  def test_permit_nothing
    actual = { a: 1, b: 2, c: 3 }
    actual.permit!
    assert_equal({}, actual)
  end
end
