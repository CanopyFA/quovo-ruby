require 'init'
class TestSensitive < Minitest::Test
  using Quovo::Refinements::Sensitive

  KEYS = %w(username password question answer access_token choices questions).freeze
  MASK = '[FILTERED]'.freeze

  def test_sensitive_hash_filter
    fields = KEYS.map { |f| [f, 'value'] }.to_h
    assert_equal(fields.sensitive?, true)
    filtered = fields.strip_sensitive
    fields.each_pair do |field, _|
      assert_equal(MASK, filtered[field])
    end
  end

  def test_sensitive_hash_nested_filter
    fields = KEYS.map { |f| [f, 'value'] }.to_h
    assert_equal({ value: fields }.sensitive?, true)
    filtered = { value: fields }.strip_sensitive[:value]
    fields.each_pair do |field, _|
      assert_equal(MASK, filtered[field])
    end
  end

  def test_sensitive_hash_ok
    fields = { id: 1, value: 200, ticker: 'MFST' }
    assert_equal(fields.sensitive?, false)
    filtered = fields.strip_sensitive
    fields.each_pair do |field, value|
      assert_equal(value, filtered[field])
    end
  end

  def test_sensitive_array_filter
    fields = KEYS.map { |f| [f, 'value'] }.to_h
    assert_equal([fields].sensitive?, true)
    filtered = [fields].strip_sensitive[0]
    fields.each_pair do |field, _|
      assert_equal(MASK, filtered[field])
    end
  end

  def test_sensitive_obj
    expected = 'username'
    actual = expected.strip_sensitive
    assert_equal(expected, actual)
  end
end
