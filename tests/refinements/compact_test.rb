require 'init'
class TestCompact < Minitest::Test
  using Quovo::Refinements::Compact

  def test_compact_hash
    actual = { a: nil, b: 1, c: 2 }
    actual.compact!
    assert_equal({ b: 1, c: 2 }, actual)
  end
end
