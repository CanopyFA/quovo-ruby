require 'init'
class TestApiAccounts < TestApi

  def test_accounts_all
    list = [
      simple_account(1),
      simple_account(2),
      simple_account(3)
    ]
    fake(:get, "/accounts", {}, { 'accounts' => list })

    accounts = Quovo.accounts.all
    assert_equal(accounts.length, 3)
    assert_type(accounts, Quovo::Models::Account)
    assert_content(list, accounts)
  end

  def test_accounts_find
    id       = 1
    expected = simple_account(id)
    fake(:get, "/accounts/#{id}", {}, { 'account' => expected })

    actual = Quovo.accounts.find(id)
    assert_type([actual], Quovo::Models::Account)
    assert_content([expected], [actual])
  end

  def test_accounts_create
    params   = {user: 1, brokerage: 1, username: 'quovo_test_user1', password: 'fakepwd'}
    expected = simple_account(1)
    fake(:post, "/accounts", params, { 'account' => expected })

    account = Quovo.accounts.create(params)
    assert_type([account], Quovo::Models::Account)
    assert_content([expected], [account])
  end

  def test_accounts_update
    id       = 1
    params   = {username: 'quovo_test_user1', password: 'fakepwd1'}
    expected = simple_account(id)
    fake(:put, "/accounts/#{id}", params, { 'account' => expected })

    account = Quovo.accounts.update(id, params)
    assert_type([account], Quovo::Models::Account)
    assert_content([expected], [account])
  end

  def test_accounts_delete
    id = 1
    fake(:delete, "/accounts/#{id}", {}, nil)

    nothing = Quovo.accounts.delete(id)
    assert_equal({}, nothing)
  end

  def test_accounts_for_user
    id = 1
    list = [
      simple_account(1),
      simple_account(2),
      simple_account(3)
    ]
    fake(:get, "/users/#{id}/accounts", {}, { 'accounts' => list })

    accounts = Quovo.accounts.for_user(id)
    assert_equal(accounts.length, 3)
    assert_type(accounts, Quovo::Models::Account)
    assert_content(list, accounts)
  end

  def test_accounts_for_sync!
    id = 1
    expected = sync(1, false, nil, nil, 'queued')
    fake(:post, "/accounts/#{id}/sync", {}, { 'sync' => expected })
    actual = Quovo.accounts.sync!(id)
    assert_instance_of(Quovo::Models::Sync, actual)
    assert_equal(expected, actual.to_h)
  end

  def test_accounts_for_sync
    id = 1
    expected = sync(1, false, nil, nil, 'syncing')
    fake(:get, "/accounts/#{id}/sync", {}, { 'sync' => expected })
    actual = Quovo.accounts.sync(id)
    assert_instance_of(Quovo::Models::Sync, actual)
    assert_equal(expected, actual.to_h)
  end

  # helpers
  def account(*args)
    instance(Quovo::Models::Account, *args)
  end

  def sync(*args)
    instance(Quovo::Models::Sync, *args)
  end

  def simple_account(i)
    account(i, nil, false, i, 'Test Data', i, "quovo_test_user#{i}", 'good', i * 100.0, nil, 0, i, '2016-01-01T12:00:00.000', '2016-01-01T12:00:00.000')
  end
end
