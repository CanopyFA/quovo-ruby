require 'init'
class TestApiHistory < TestApi

  def test_history_for_user
    id = 1
    expected = [
      simple_transaction(1),
      simple_transaction(1),
      simple_transaction(3)
    ]
    params = { start_date: "2015-01-05", end_date: "2015-05-05"}
    fake(:get, "/users/#{id}/history", params, { 'history' => expected })
    
    actual = Quovo.history.for_user(id, params)
    assert_equal(actual.length, 3)
    assert_type(actual, Quovo::Models::Transaction)
    assert_content(expected, actual)
  end

  def test_history_for_account
    id = 1
    expected = [
      simple_transaction(1),
      simple_transaction(1),
      simple_transaction(3)
    ]
    params = { start_date: "2015-01-05", end_date: "2015-05-05"}
    fake(:get, "/accounts/#{id}/history", params, { 'history' => expected })
    
    actual = Quovo.history.for_account(id, params)
    assert_equal(actual.length, 3)
    assert_type(actual, Quovo::Models::Transaction)
    assert_content(expected, actual)
  end

  def test_history_for_portfolio
    id = 1
    expected = [
      simple_transaction(1),
      simple_transaction(1),
      simple_transaction(3)
    ]
    params = { start_date: "2015-01-05", end_date: "2015-05-05"}
    fake(:get, "/portfolios/#{id}/history", params, { 'history' => expected })
    
    actual = Quovo.history.for_portfolio(id, params)
    assert_equal(actual.length, 3)
    assert_type(actual, Quovo::Models::Transaction)
    assert_content(expected, actual)
  end

  # helpers
  def transaction(*args)
    instance(Quovo::Models::Transaction, *args)
  end

  def simple_transaction(i)
    transaction(1, nil, "594918104", "2015-05-01", nil, 0.0, 1.0, i, "Bought MSFT", 1, 40.0, 9.0, "MSFT", "Microsoft Corporation", "B", "BUYL", 1, -360.0)
  end
end
