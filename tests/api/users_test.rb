require 'init'
class TestApiUsers < TestApi

  def test_users_all
    expected = [
      simple_user(1),
      simple_user(2),
      simple_user(3)
    ]
    fake(:get, "/users", {}, { 'users' => expected })

    actual = Quovo.users.all
    assert_equal(actual.length, 3)
    assert_type(actual, Quovo::Models::User)
    assert_content(expected, actual)
  end

  def test_users_find
    id       = 1
    expected = simple_user(id)
    fake(:get, "/users/#{id}", {}, { 'user' => expected })

    actual = Quovo.users.find(id)
    assert_type([actual], Quovo::Models::User)
    assert_content([expected], [actual])
  end

  def test_users_create
    params   = {username: 'quovo_test_user', name: 'Quovo Testuser', email: 'testuser@quovo.com'}
    expected = simple_user(1)
    fake(:post, "/users", params, { 'user' => expected })

    actual = Quovo.users.create(params)
    assert_type([actual], Quovo::Models::User)
    assert_content([expected], [actual])
  end

  def test_users_update
    id       = 1
    params   = {name: 'Quovo Testuser', email: 'testuser@quovo.com'}
    expected = simple_user(id)
    fake(:put, "/users/#{id}", params, { 'user' => expected })

    actual = Quovo.users.update(id, params)
    assert_type([actual], Quovo::Models::User)
    assert_content([expected], [actual])
  end

  def test_users_delete
    id = 1
    fake(:delete, "/users/#{id}", {}, nil)

    nothing = Quovo.users.delete(id)
    assert_equal({}, nothing)
  end

  # helpers
  def user(*args)
    instance(Quovo::Models::User, *args)
  end

  def simple_user(i)
    user(i, "quovo_test_user", "testuser@quovo.com", "Quovo Testuser", nil, 173471.15110)
  end
end
