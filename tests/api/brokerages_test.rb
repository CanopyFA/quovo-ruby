require 'init'
class TestApiBrokerages < TestApi

  def test_brokerages_all
    list = [
      simple_brokerage(1),
      simple_brokerage(2),
      simple_brokerage(3)
    ]
    fake(:get, "/brokerages", {}, { 'brokerages' => list })

    brokerages = Quovo.brokerages.all
    assert_equal(brokerages.length, 3)
    assert_type(brokerages, Quovo::Models::Brokerage)
    assert_content(list, brokerages)
  end

  def test_brokerages_find
    id       = 1
    expected = simple_brokerage(id)
    fake(:get, "/brokerages/#{id}", {}, { 'brokerage' => expected })

    actual = Quovo.brokerages.find(id)
    assert_type([actual], Quovo::Models::Brokerage)
    assert_content([expected], [actual])
  end

  # helpers
  def brokerage(*args)
    instance(Quovo::Models::Brokerage, *args)
  end

  def simple_brokerage(i)
    brokerage(i, false, "Brokerage #{i}", nil, nil, nil, "www.example.com")
  end
end
