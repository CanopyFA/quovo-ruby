require 'init'
class TestRequire < Minitest::Test
  using Quovo::Refinements::Require

  def test_require_param
    id = nil
    assert_raises(Quovo::ParamsError) do
      id.require!(:id)
    end
  end

  def test_require_hash_ok
    { a: 1, b: 2, c: 3 }.require!(:a, :b, :c)
  end

  def test_require_hash_missing
    assert_raises(Quovo::ParamsError) do
      { a: 1, b: 2 }.require!(:a, :b, :c)
    end
  end

  def test_require_hash_nil_value
    assert_raises(Quovo::ParamsError) do
      { a: 1, b: nil }.require!(:a, :b)
    end
  end
end
