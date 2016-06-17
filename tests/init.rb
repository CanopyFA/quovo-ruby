require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'minitest/pride'
require 'quovo'

Quovo.fake!

class TestApi < Minitest::Test
  def instance(model, *args)
    props = model.fields.zip(args)
    model.new(props).to_h
  end

  def fake(method, path, params, response)
    Quovo.fake!([[method, path, params, response]])
  end

  def assert_type(items, model)
    items.each do |item|
      assert_instance_of(model, item)
    end
  end

  def assert_content(expected_items, actual_items)
    expected_items.zip(actual_items).each do |expected, actual|
      assert_equal(expected, actual.to_h)
    end
  end
end
