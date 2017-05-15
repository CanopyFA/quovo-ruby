require 'init'
class TestApiIframeToken < TestApi
  def test_create_token
    expected = instance(Quovo::Models::IframeToken, 1, 'token_value')
    fake(:post, '/iframe_token', { user: 1 }, 'iframe_token' => expected)

    token = Quovo.iframe_token.create(1)
    assert_type([token], Quovo::Models::IframeToken)
    assert_content([expected], [token])
    assert_equal(token.url, 'https://embed.quovo.com/auth/token_value')
  end
end
