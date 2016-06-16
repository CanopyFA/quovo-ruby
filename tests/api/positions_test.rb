require 'init'
class TestApiPositions < TestApi

  def test_positions_for_user
    id = 1
    expected = [
      simple_position(1),
      simple_position(2),
      simple_position(3)
    ]
    fake(:get, "/users/#{id}/positions", {}, { 'positions' => expected })

    actual = Quovo.positions.for_user(id)
    assert_equal(actual.length, 3)
    assert_type(actual, Quovo::Models::Position)
    assert_content(expected, actual)
  end

  def test_positions_for_account
    id = 1
    expected = [
      simple_position(1),
      simple_position(2),
      simple_position(3)
    ]
    fake(:get, "/accounts/#{id}/positions", {}, { 'positions' => expected })

    actual = Quovo.positions.for_account(id)
    assert_equal(actual.length, 3)
    assert_type(actual, Quovo::Models::Position)
    assert_content(expected, actual)
  end

  def test_positions_for_portfolio
    id = 1
    expected = [
      simple_position(1),
      simple_position(2),
      simple_position(3)
    ]
    fake(:get, "/portfolios/#{id}/positions", {}, { 'positions' => expected })

    actual = Quovo.positions.for_portfolio(id)
    assert_equal(actual.length, 3)
    assert_type(actual, Quovo::Models::Position)
    assert_content(expected, actual)
  end

  # helpers
  def position(*args)
    instance(Quovo::Models::Position, *args)
  end

  def simple_position(i)        
    position(1, "Large Cap Equity", nil, nil, nil, "037833100", 1.0, i, "2015-05-05", "NSD", 746745, "test port", 105.19, 12.0, "Technology", "Equity", "AAPL", "Apple Inc", 1, "quovo_test_user", 1262.28)
  end
end
