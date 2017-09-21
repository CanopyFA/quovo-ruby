require 'init'
class TestApiPortfolios < TestApi
  def test_porfolios_all
    expected = [
      simple_portfolio(1),
      simple_portfolio(2),
      simple_portfolio(3)
    ]
    fake(:get, '/portfolios', {}, 'portfolios' => expected)

    actual = Quovo.portfolios.all
    assert_equal(actual.length, 3)
    assert_type(actual, Quovo::Models::Portfolio)
    assert_content(expected, actual)
  end

  def test_porfolios_for_user
    id = 1
    expected = [
      simple_portfolio(1),
      simple_portfolio(2),
      simple_portfolio(3)
    ]
    fake(:get, "/users/#{id}/portfolios", {}, 'portfolios' => expected)
    actual = Quovo.portfolios.for_user(id)
    assert_equal(actual.length, 3)
    assert_type(actual, Quovo::Models::Portfolio)
    assert_content(expected, actual)
  end

  def test_porfolios_for_account
    id = 1
    expected = [
      simple_portfolio(1),
      simple_portfolio(2),
      simple_portfolio(3)
    ]
    fake(:get, "/accounts/#{id}/portfolios", {}, 'portfolios' => expected)
    actual = Quovo.portfolios.for_account(id)
    assert_equal(actual.length, 3)
    assert_type(actual, Quovo::Models::Portfolio)
    assert_content(expected, actual)
  end

  def test_porfolios_find
    id = 1
    expected = simple_portfolio(id)
    fake(:get, "/portfolios/#{id}", {}, 'portfolio' => expected)

    actual = Quovo.portfolios.find(id)
    assert_type([actual], Quovo::Models::Portfolio)
    assert_content([expected], [actual])
  end

  def test_porfolios_update
    id       = 1
    params   = { portfolio_type: 'Checking' }
    expected = simple_portfolio(id)
    fake(:put, "/portfolios/#{id}", params, 'portfolio' => expected)

    actual = Quovo.portfolios.update(id, params)
    assert_type([actual], Quovo::Models::Portfolio)
    assert_content([expected], [actual])
  end

  # helpers
  def portfolio(*args)
    instance(Quovo::Models::Portfolio, *args)
  end

  def simple_portfolio(i)
    portfolio(i, 1, 1, 'Test Data Brokerage', 'A Sample Portfolio', false, true, '2016-01-01T12:00:00.000', 'My Portfolio II', 'Individual Account', 'Investment Account', 'Brokerage Account', 'Brokerage Account', 'Investment', 3, 1, 'quovo_test_user', 73_479, 'Very High')
  end
end
