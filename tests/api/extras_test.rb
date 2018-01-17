require 'init'
class TestApiExtras < TestApi
  def test_extras_for_portfolio
    id = 1
    expected = [simple_extra(1)]
    fake(:get, "/portfolios/#{id}/extras", {}, 'extras' => expected)

    actual = Quovo.extras.for_portfolio(id)
    assert_equal(actual.length, 1)
    assert_type(actual, Quovo::Models::Extra)
    assert_content(expected, actual)
  end

  # helpers
  def extra(*args)
    instance(Quovo::Models::Extra, *args)
  end

  def simple_extra(i)
    extra('Cash APR', 2000, '2018-01-01', '1', true, 300, '2018-01-01', 1400, '2018-01-01', 'Auto Loan', '2018-01-01', 50, 4000, '2018-01-01', i, 2, 3)
  end
end
